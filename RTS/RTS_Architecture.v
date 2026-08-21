`timescale 1 ns / 1ns

module RTS_Architecture ();

  parameter PRPG_Size    = 12; 
  parameter SRSG_Size    = 40; 
  parameter MISR_Size    = 4;  
  parameter SISA_Size    = 40; 

  reg [MISR_Size - 1:0] Golden_MISR_Out; 
  reg [SISA_Size - 1:0] Golden_SISA_Out;
  wire [SISA_Size - 1:0] SISA_Out; 
  wire [MISR_Size - 1:0] MISR_Out; 
  real coverage;
  reg [10*60:0] wireName;
  reg stuckAtVal;
  wire [MISR_Size-1:0] PO; 
  wire PRPG_En, MISR_En, SISA_En, SRSG_En;

  wire valid_out = 1;    
  wire valid_in = 1; 
  wire [3:0] conv_result; 
  assign PO = conv_result; 

  reg [PRPG_Size - 1:0] PRPG_Seed;
  reg [SRSG_Size - 1:0] SRSG_Seed;
  reg [MISR_Size - 1:0] MISR_Seed;
  reg [SISA_Size - 1:0] SISA_Seed;

  reg [PRPG_Size - 1:0] PRPG_Poly;
  reg [SRSG_Size - 1:0] SRSG_Poly;
  reg [MISR_Size - 1:0] MISR_Poly;
  reg [SISA_Size - 1:0] SISA_Poly;
  wire [PRPG_Size - 1:0] PRPG_Out;

  integer cfgFile, sigFile, resultFile ,faultFile;
  integer status;
  integer numOfFaults;
  integer numOfDetected;
  
  reg clk = 0;
  reg Rst;
  wire internalRst;
  wire done;
  wire So, Si ,NbarT;
  reg  first = 1;
  top_convolver_net CUT (
    .clk(clk),
    .rst(Rst),        
    .valid_in(valid_in),     
    .pixel_1(PRPG_Out[0]),
    .pixel_2(PRPG_Out[1]), 
    .pixel_3(PRPG_Out[2]), 
    .coeff_11(PRPG_Out[3]),
    .coeff_12(PRPG_Out[4]),
    .coeff_13(PRPG_Out[5]),
    .coeff_21(PRPG_Out[6]),
    .coeff_22(PRPG_Out[7]),
    .coeff_23(PRPG_Out[8]),
    .coeff_31(PRPG_Out[9]),
    .coeff_32(PRPG_Out[10]),
    .coeff_33(PRPG_Out[11]),
    .valid_out(valid_out),
    .conv_result(conv_result),
    .NbarT(NbarT), 
    .Si(Si), 
    .So(So) 
  );

  PRPG #(PRPG_Size) PRPG (
    .clk(clk),
    .internalRst(internalRst),
    .PRPG_En(PRPG_En),
    .PRPG_Poly(PRPG_Poly),
    .PRPG_Seed(PRPG_Seed),
    .PRPG_Out(PRPG_Out)
  ); 


  SRSG #(SRSG_Size) SRSG (
    .clk(clk),
    .internalRst(internalRst),
    .SRSG_En(SRSG_En),
    .SRSG_Poly(SRSG_Poly),
    .SRSG_Seed(SRSG_Seed),
    .SRSG_Out(Si)
  );

  SISA #(SISA_Size) SISA (
    .clk(clk),
    .internalRst(internalRst),
    .SISA_En(SISA_En),
    .poly(SISA_Poly),
    .seed(SISA_Seed),
    .So(So),
    .out(SISA_Out)
  );
    MISR #(MISR_Size) MISR(
    .clk(clk),
    .internalRst(internalRst),
    .MISR_En(MISR_En),
    .MISR_Poly(MISR_Poly),
    .MISR_Seed(MISR_Seed),
    .input_data(PO),
    .MISR_Out(MISR_Out)
  );


  RTS_Controller RTS_Controller (
    .clk(clk),
    .rstIn(Rst),
    .NbarT(NbarT),
    .rstOut(internalRst),
    .PRPG_En(PRPG_En),
    .SRSG_En(SRSG_En),
    .SISA_En(SISA_En),
    .MISR_En(MISR_En),
    .done(done)
  );

  always #1 clk = !clk;
initial begin
    sigFile = $fopen("Signature.txt", "w");
    cfgFile = $fopen("Configuration.txt", "r"); 
    while (!$feof(cfgFile)) begin
      Rst = 1'b1; #1 Rst = 1'b0;
      status = $fscanf(cfgFile, "%b %b %b %b %b %b %b %b\n", PRPG_Poly, SRSG_Poly, MISR_Poly, SISA_Poly, PRPG_Seed, SRSG_Seed, MISR_Seed, SISA_Seed);
      @(posedge done);
      $fwrite(sigFile, "%b %b\n", MISR_Out, SISA_Out);
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
      status = $fscanf(sigFile, "%b %b\n", Golden_MISR_Out, Golden_SISA_Out);
      status = $fscanf(cfgFile, "%b %b %b %b %b %b %b %b\n", PRPG_Poly, SRSG_Poly, MISR_Poly, SISA_Poly, PRPG_Seed, SRSG_Seed, MISR_Seed, SISA_Seed);

      while (!$feof(faultFile)) begin
        status = $fscanf(faultFile, "%s s@%b\n", wireName, stuckAtVal);
        numOfFaults = numOfFaults + 1;
        $InjectFault(wireName, stuckAtVal);

        Rst = 1'b1; #1 Rst = 1'b0;
        @(posedge done); 
         if ({MISR_Out, SISA_Out} != {Golden_MISR_Out, Golden_SISA_Out}) begin
              numOfDetected = numOfDetected + 1;
        $display("%b ,%b %b ,%b", Golden_MISR_Out, MISR_Out, Golden_SISA_Out, SISA_Out);
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
    $fwrite(resultFile, "%b %b %b %b %b %b %b %b %f\n", PRPG_Poly, SRSG_Poly, MISR_Poly, SISA_Poly, PRPG_Seed, SRSG_Seed, MISR_Seed, SISA_Seed, coverage);
    end
    end

    $fclose(cfgFile);
    $fclose(sigFile);
    $fclose(resultFile);
    $finish;
end
endmodule