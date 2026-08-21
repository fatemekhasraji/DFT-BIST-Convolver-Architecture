module STUMPS_Controller #(
    parameter ShiftSize = 14,
    parameter numOfTstCycl = 5
)(
    input wire clk, 
    input wire rstIn, 
    output reg NbarT, 
    output reg rstOut, 
    output reg PRPG1_En,
    output reg PRPG2_En, 
    output reg MISR1_En, 
    output reg MISR2_En, 
    output reg done
);

    `define Reset 3'b000
    `define GenData 3'b001
    `define ShiftData 3'b010
    `define NormalMode 3'b011
    `define GenSignature 3'b100
    `define Exit 3'b101
         
    reg [2:0] present_state, next_state;
    reg [$clog2(ShiftSize)-1:0] shtCount;
    reg [$clog2(numOfTstCycl)-1:0] testVectorCount;
    reg shtCount_Rst, shtCount_En;
    reg testCount_Rst, testCount_En;

    always @(posedge clk or posedge rstIn) begin
        if (rstIn)
            present_state <= `Reset;
        else
            present_state <= next_state;
    end

    always @(posedge clk) begin
        if (shtCount_Rst)
            shtCount <= 0;
        else if (shtCount_En)
            shtCount <= shtCount + 1;
    end

    always @(posedge clk) begin
        if (testCount_Rst)
            testVectorCount <= 0;
        else if (testCount_En)
            testVectorCount <= testVectorCount + 1;
    end

    always @(present_state or shtCount) begin : Combinatorial
        NbarT = 1'b0;
        rstOut = 1'b0;
        MISR1_En = 1'b0;
        PRPG1_En = 1'b0;
        MISR2_En = 1'b0;
        PRPG2_En = 1'b0;
        done = 1'b0;
        shtCount_Rst = 1'b0;
        shtCount_En = 1'b0;
        testCount_Rst = 1'b0;
        testCount_En = 1'b0;

        case (present_state)
            `Reset: begin
                next_state = `GenData;
                rstOut = 1'b1;
                NbarT = 1'b1;
                testCount_Rst = 1'b1;
            end

            `GenData: begin
                next_state = `ShiftData;
                PRPG1_En = 1'b1;
                shtCount_Rst = 1'b1;
            end

            `ShiftData: begin
                next_state = (shtCount < ShiftSize - 1) ? `ShiftData : `NormalMode;
                shtCount_En = 1'b1;
                PRPG2_En = 1'b1;
                MISR2_En = 1'b1;
                NbarT = 1'b1;
            end

            `NormalMode: begin
                next_state = `GenSignature;
                NbarT = 1'b0;
            end

            `GenSignature: begin
                next_state = (testVectorCount < numOfTstCycl - 1) ? `GenData : `Exit;
                testCount_En = 1'b1;
                MISR1_En = 1'b1;
            end

            `Exit: begin
                next_state = `Exit;
                done = 1'b1;
            end

            default: next_state = `Reset;
        endcase
    end
endmodule