// 1. PRPG - For generating 15-bit test patterns for inputs
module PRPG #(parameter PRPG_Size = 15) (
    input clk, internalRst, PRPG_En, 
    input [PRPG_Size - 1:0] PRPG_Poly, PRPG_Seed,
    output reg [PRPG_Size - 1:0] PRPG_Out
);
    integer i;
    always @(posedge clk or posedge internalRst) begin
        if (internalRst == 1'b1)
            PRPG_Out <= PRPG_Seed;
        else if (PRPG_En == 1'b1) begin
            PRPG_Out[PRPG_Size - 1] <= PRPG_Out[0];
            for (i = 0; i < PRPG_Size - 1; i = i + 1) begin
                PRPG_Out[i] <= (PRPG_Out[0] & PRPG_Poly[i]) ^ PRPG_Out[i + 1];
            end 
        end
    end
endmodule

// 2. SRSG - For generating patterns for 48 flip-flops
module SRSG #(parameter SRSG_Size = 48) (
    input  wire clk,
    input  wire internalRst,
    input  wire SRSG_En,
    input  wire [SRSG_Size-1:0] SRSG_Poly,
    input  wire [SRSG_Size-1:0] SRSG_Seed,
    output reg SRSG_Out
);
    reg [SRSG_Size-1:0] lfsr; // Added internal LFSR register

    always @(posedge clk or posedge internalRst) begin
        if (internalRst) begin
            lfsr <= SRSG_Seed;
            SRSG_Out <= SRSG_Seed[0];
        end
        else if (SRSG_En) begin
            // LFSR feedback
            lfsr <= {lfsr[SRSG_Size-2:0], 
                    ^(lfsr & SRSG_Poly)};
            SRSG_Out <= lfsr[0];
        end
    end
endmodule 

// 3. SISA - For analyzing 5-bit responses
module SISA #(parameter size = 5) (
    input clk, internalRst, SISA_En, 
    input [size - 1:0] poly, seed,
    input So,
    output reg [size - 1:0] out
);
    integer i;

    always @(posedge clk or posedge internalRst) begin
        if (internalRst == 1'b1)
            out <= seed;
        else if (SISA_En == 1'b1) begin
            out[size - 1] <= out[0] ^ So;
            for (i = 0; i < size - 1; i = i + 1) begin
                out[i] <= (out[0] & poly[i]) ^ out[i + 1];
            end 
        end
    end
endmodule

// 4. MISR - For 5-bit output signature

module MISR #(parameter MISR_Size = 5) (
    input wire clk,
    input wire internalRst,
    input wire MISR_En,
    input wire [MISR_Size-1:0] MISR_Poly,
    input wire [MISR_Size-1:0] MISR_Seed,
    input wire [MISR_Size-1:0] input_data,
    output reg [MISR_Size-1:0] MISR_Out
);

  always @(posedge clk) begin
    if (internalRst)
      MISR_Out <= MISR_Seed;
    else if(MISR_En)
      MISR_Out <= input_data ^ ({MISR_Size{MISR_Out[0]}} & MISR_Poly) ^ {1'b0, MISR_Out[MISR_Size-1:1]};
  end

endmodule
