// 5-tap FIR Filter
module fir_filter (
    input clk,
    input reset,
    input signed [7:0] x_in,     // 8-bit signed input sample
    output reg signed [15:0] y_out  // 16-bit signed output
);

    // Filter Coefficients (Example: h = [1, 2, 3, 2, 1])
    parameter signed [7:0] h0 = 8'd1;
    parameter signed [7:0] h1 = 8'd2;
    parameter signed [7:0] h2 = 8'd3;
    parameter signed [7:0] h3 = 8'd2;
    parameter signed [7:0] h4 = 8'd1;

    // Shift Registers for input samples
    reg signed [7:0] x_reg0, x_reg1, x_reg2, x_reg3, x_reg4;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            x_reg0 <= 0;
            x_reg1 <= 0;
            x_reg2 <= 0;
            x_reg3 <= 0;
            x_reg4 <= 0;
            y_out <= 0;
        end else begin
            // Shift the input samples
            x_reg4 <= x_reg3;
            x_reg3 <= x_reg2;
            x_reg2 <= x_reg1;
            x_reg1 <= x_reg0;
            x_reg0 <= x_in;

            // Multiply-Accumulate Operation
            y_out <= (h0 * x_reg0) +
                     (h1 * x_reg1) +
                     (h2 * x_reg2) +
                     (h3 * x_reg3) +
                     (h4 * x_reg4);
        end
    end

endmodule
