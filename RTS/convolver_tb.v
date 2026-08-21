module convolver_tb;
    parameter IMG_WIDTH  = 1;
    parameter COEF_WIDTH = 1;
    parameter MULT_WIDTH = IMG_WIDTH + COEF_WIDTH;
    parameter SUM1_WIDTH = MULT_WIDTH + 1;
    parameter ROW_SUM_WIDTH = SUM1_WIDTH + 1;
    parameter RESULT_WIDTH = ROW_SUM_WIDTH ;
    reg clk;
    reg rst;
    reg valid_in;
    reg signed [IMG_WIDTH-1:0] pixel_1, pixel_2, pixel_3;
    reg signed [COEF_WIDTH-1:0] coeff_11, coeff_12, coeff_13;
    reg signed [COEF_WIDTH-1:0] coeff_21, coeff_22, coeff_23;
    reg signed [COEF_WIDTH-1:0] coeff_31, coeff_32, coeff_33;

    wire valid_out;
    wire signed [RESULT_WIDTH-1:0] conv_result;
    reg signed [RESULT_WIDTH-1:0] expected_result;
    top_convolver dut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .pixel_1(pixel_1),
        .pixel_2(pixel_2), 
        .pixel_3(pixel_3),
        .coeff_11(coeff_11), .coeff_12(coeff_12), .coeff_13(coeff_13),
        .coeff_21(coeff_21), .coeff_22(coeff_22), .coeff_23(coeff_23),
        .coeff_31(coeff_31), .coeff_32(coeff_32), .coeff_33(coeff_33),
        .valid_out(valid_out),
        .conv_result(conv_result)
    );

    function automatic [RESULT_WIDTH-1:0] calculate_expected;
        input [IMG_WIDTH-1:0] p1, p2, p3;
        input [COEF_WIDTH-1:0] c11, c12, c13, c21, c22, c23, c31, c32, c33;
        reg [MULT_WIDTH-1:0] m11, m12, m13, m21, m22, m23, m31, m32, m33;
        reg [SUM1_WIDTH-1:0] row1_sum1, row2_sum1, row3_sum1;
        reg [ROW_SUM_WIDTH-1:0] row1_final, row2_final, row3_final;
        begin
            m11 = p1*c11;
            m12 = p1*c12;
            m13 = p1*c13;
            m21 = p2*c21;
            m22 = p2*c22;
            m23 = p2*c23;
            m31 = p3*c31;
            m32 = p3*c32;
            m33 = p3*c33;
            row1_sum1 = m11+ m12;
            row2_sum1 = m21+ m22;
            row3_sum1 = m31+ m32;
            row1_final = row1_sum1 + m13;
            row2_final = row2_sum1 + m23;
            row3_final = row3_sum1 + m33;
            calculate_expected = row1_final + row2_final + row3_final;
        end
    endfunction
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    always @(posedge clk) begin
        if (!rst && valid_out) begin
                expected_result = calculate_expected(
                    pixel_1, pixel_2, pixel_3,
                    coeff_11, coeff_12, coeff_13,
                    coeff_21, coeff_22, coeff_23,
                    coeff_31, coeff_32, coeff_33
                );
                
                if ($signed(conv_result) == expected_result)
                    $display("PASSED: Expected=%0b, Got=%0b", 
                            expected_result, $signed(conv_result));
                else
                    $display("FAILED: Expected=%0b, Got=%0b", 
                            expected_result, $signed(conv_result));
            end
    end

    initial begin
        rst = 0;
        valid_in = 1;
        
//        pixel_1 = 1; 
//        pixel_2 = 1; 
//        pixel_3 = 1;
//        coeff_11 = 1; coeff_12 = 1; coeff_13 = 1;
//        coeff_21 = 1; coeff_22 = 1; coeff_23 = 1;
//        coeff_31 = 1; coeff_32 = 1; coeff_33 = 1;
        
        pixel_1 = 1; 
        pixel_2 = 0; 
        pixel_3 = 1;
        coeff_11 = 1; coeff_12 = 0; coeff_13 = 1;
        coeff_21 = 1; coeff_22 = 1; coeff_23 = 1;
        coeff_31 = 0; coeff_32 = 0; coeff_33 = 0;
        
        repeat(7) @(posedge clk);
        valid_in = 0;

        repeat(2) @(posedge clk);
        $finish;
    end

endmodule