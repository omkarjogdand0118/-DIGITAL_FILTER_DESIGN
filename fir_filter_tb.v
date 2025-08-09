`timescale 1ns/1ps

module fir_filter_tb;

    reg clk;
    reg reset;
    reg signed [7:0] x_in;
    wire signed [15:0] y_out;

    // Instantiate the FIR Filter
    fir_filter uut (
        .clk(clk),
        .reset(reset),
        .x_in(x_in),
        .y_out(y_out)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        $monitor("Time=%0d x_in=%d y_out=%d", $time, x_in, y_out);
        clk = 0;
        reset = 1;
        x_in = 0;
        #10;
        reset = 0;

        // Apply input samples
        x_in = 8'd5;  #10;
        x_in = 8'd10; #10;
        x_in = 8'd15; #10;
        x_in = 8'd10; #10;
        x_in = 8'd5;  #10;
        x_in = 8'd0;  #10;
        x_in = 8'd0;  #10;

        #50;
        $finish;
    end

endmodule
