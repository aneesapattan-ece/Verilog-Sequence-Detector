module testbench;

reg clk;
reg reset;
reg din;

wire detect;

sequence_detector_1011 uut(
    .clk(clk),
    .reset(reset),
    .din(din),
    .detect(detect)
);

always #5 clk = ~clk;

initial
begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);

    clk = 0;
    reset = 1;
    din = 0;

    #10 reset = 0;

    // Input sequence: 1011011
    din = 1; #10;
    din = 0; #10;
    din = 1; #10;
    din = 1; #10;   // Detect here

    din = 0; #10;
    din = 1; #10;
    din = 1; #10;

    #20;

    $finish;
end

endmodule