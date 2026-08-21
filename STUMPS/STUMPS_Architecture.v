module STUMPS_Architecture();

    parameter PRPG1_Size = 12;
    parameter PRPG2_Size = 14;
    parameter MISR1_Size = 4;
    parameter MISR2_Size = 12;

    reg [MISR1_Size-1:0] Golden_MISR1_Out;
    reg [MISR2_Size-1:0] Golden_MISR2_Out;
    wire [MISR1_Size-1:0] MISR1_Out;
    wire [PRPG1_Size-1:0] PRPG1_Out;
    wire [MISR2_Size-1:0] MISR2_Out;
    wire [PRPG2_Size-1:0] PRPG2_Out;  
    real coverage;

    reg [10*60:0] wireName;
    reg stuckAtVal;
    wire PRPG1_En, PRPG2_En, MISR1_En, MISR2_En;
    wire valid_out = 1;    
    wire valid_in = 1; 
    wire [3:0] conv_result; 

    reg [PRPG1_Size - 1:0] PRPG1_Seed;
    reg [PRPG2_Size - 1:0] PRPG2_Seed;
    reg [MISR1_Size - 1:0] MISR1_Seed;
    reg [MISR2_Size - 1:0] MISR2_Seed;

    reg [PRPG1_Size - 1:0] PRPG1_Poly;
    reg [PRPG2_Size - 1:0] PRPG2_Poly;
    reg [MISR1_Size - 1:0] MISR1_Poly;
    reg [MISR2_Size - 1:0] MISR2_Poly;

    integer cfgFile, sigFile, resultFile ,faultFile;
    integer status;
    integer numOfFaults;
    integer numOfDetected;

    reg clk = 0;
    reg Rst;
    wire internalRst;
    wire done;
    reg  first = 1;
    wire So1, So2, So3;
    wire Si1, Si2, Si3;
    wire NbarT;

    top_convolver_net CUT (
      .clk(clk),
      .rst(internalRst),
      .valid_in(valid_in),     
      .pixel_1(PRPG1_Out[11]),
      .pixel_2(PRPG1_Out[10]),
      .pixel_3(PRPG1_Out[9]),      
      .coeff_11(PRPG1_Out[8]),
      .coeff_12(PRPG1_Out[7]),  
      .coeff_13(PRPG1_Out[6]),
      .coeff_21(PRPG1_Out[5]),
      .coeff_22(PRPG1_Out[4]),
      .coeff_23(PRPG1_Out[3]), 
      .coeff_31(PRPG1_Out[2]),
      .coeff_32(PRPG1_Out[1]),
      .coeff_33(PRPG1_Out[0]), 
      .valid_out(valid_out),                          
      .conv_result(conv_result),
      .NbarT(NbarT),
      .Si1(Si1),
      .Si2(Si2),
      .Si3(Si3),
      .So1(So1),
      .So2(So2),
      .So3(So3)
    );
  
    // PRPG 1 instance
    PRPG #(PRPG1_Size) PRPG1 (
        .clk(clk),
        .internalRst(internalRst),
        .PRPG_En(PRPG1_En),
        .PRPG_Poly(PRPG1_Poly),
        .PRPG_Seed(PRPG1_Seed),
        .PRPG_Out(PRPG1_Out)
    );

    // PRPG 2 instance
    PRPG #(PRPG2_Size) PRPG2 (
        .clk(clk),
        .internalRst(internalRst),
        .PRPG_En(PRPG2_En),
        .PRPG_Poly(PRPG2_Poly),
        .PRPG_Seed(PRPG2_Seed),
        .PRPG_Out(PRPG2_Out)
    );
    // MISR 1 instance
    MISR #(MISR1_Size) MISR1 (
        .clk(clk),
        .internalRst(internalRst),
        .MISR_En(MISR1_En),
        .MISR_Poly(MISR1_Poly),
        .MISR_Seed(MISR1_Seed),
        .input_data(conv_result),
        .MISR_Out(MISR1_Out)
    );

    // MISR 2 instance
    MISR #(MISR2_Size) MISR2 (
        .clk(clk),
        .internalRst(internalRst),
        .MISR_En(MISR2_En),
        .MISR_Poly(MISR2_Poly),
        .MISR_Seed(MISR2_Seed),
        .input_data({3'b0, So1, 3'b0, So2, 3'b0, So3}),
        .MISR_Out(MISR2_Out)
    );

    assign {Si1, Si2, Si3} = {PRPG2_Out[8],PRPG2_Out[4],PRPG2_Out[0]}; // Same as book (bit 8, 4, 0)

    // Controller instance
    STUMPS_Controller controller (
        .clk(clk),
        .rstIn(Rst),
        .rstOut(internalRst),
        .PRPG1_En(PRPG1_En),
        .PRPG2_En(PRPG2_En),
        .MISR1_En(MISR1_En),
        .MISR2_En(MISR2_En),
        .NbarT(NbarT),
        .done(done)
    );

    always #1 clk = ~clk;

    initial begin
    sigFile = $fopen("Signature.txt", "w");
    cfgFile = $fopen("Configuration.txt", "r"); 
    while (!$feof(cfgFile)) begin
      Rst = 1'b1; #1 Rst = 1'b0;
      status = $fscanf(cfgFile, "%b %b %b %b %b %b %b %b\n", PRPG1_Poly, PRPG2_Poly, MISR1_Poly, MISR2_Poly, PRPG1_Seed, PRPG2_Seed, MISR1_Seed, MISR2_Seed);
      @(posedge done); 
      $fwrite(sigFile, "%b %b\n", MISR1_Out, MISR2_Out);
    end
    $fclose(sigFile);
    $fclose(cfgFile);

    cfgFile = $fopen("Configuration.txt", "r");
    resultFile = $fopen("Result.txt", "w");
    sigFile = $fopen("Signature.txt", "r");

    while (!$feof(cfgFile)) begin
      faultFile = $fopen("top_convolver.flt", "r");
      numOfFaults = 0;
      numOfDetected = 0;
      status = $fscanf(sigFile, "%b %b\n", Golden_MISR1_Out, Golden_MISR2_Out);
      status = $fscanf(cfgFile, "%b %b %b %b %b %b %b %b\n", PRPG1_Poly, PRPG2_Poly, MISR1_Poly, MISR2_Poly, PRPG1_Seed, PRPG2_Seed, MISR1_Seed, MISR2_Seed);

      while (!$feof(faultFile)) begin
        status = $fscanf(faultFile, "%s s@%b\n", wireName, stuckAtVal);
        numOfFaults = numOfFaults + 1;
        $InjectFault(wireName, stuckAtVal);

        Rst = 1'b1; #1 Rst = 1'b0; 
        @(posedge done); 
        if ({Golden_MISR1_Out, Golden_MISR2_Out} != {MISR1_Out, MISR2_Out}) begin
          numOfDetected = numOfDetected + 1;
          $display("%b ,%b %b ,%b", Golden_MISR1_Out, MISR1_Out, Golden_MISR2_Out, MISR2_Out);
        end
        $RemoveFault(wireName);
      end

      $fclose(faultFile);
      if (first) begin
          first = 0;
      end
      else begin
    coverage = numOfDetected * 100.0 / numOfFaults;
    $display("F Coverage: %f/%f = %f", numOfDetected, numOfFaults, coverage);
      $fwrite(resultFile, "%b %b %b %b %b %b %b %b %f\n", PRPG1_Poly, PRPG2_Poly, MISR1_Poly, MISR2_Poly, PRPG1_Seed, PRPG2_Seed, MISR1_Seed, MISR2_Seed, coverage);
      end
    end

    $fclose(cfgFile);
    $fclose(sigFile);
    $fclose(resultFile);
    $finish;
end
endmodule