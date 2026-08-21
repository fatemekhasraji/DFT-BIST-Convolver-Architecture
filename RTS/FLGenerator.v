module FLGenerator;
    reg clk;
    reg rst;

    top_convolver_net CUT (
        .clk(clk),
        .rst(rst)
    );
    initial begin
        $FaultCollapsing(FLGenerator.CUT, "top_convolver.flt");
    end
endmodule