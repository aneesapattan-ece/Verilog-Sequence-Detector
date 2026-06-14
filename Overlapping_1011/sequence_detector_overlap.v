module sequence_detector_overlap(
    input clk,
    input reset,
    input din,
    output reg detect
);

reg [1:0] state;

parameter S0 = 2'b00,
          S1 = 2'b01,
          S2 = 2'b10,
          S3 = 2'b11;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= S0;
        detect <= 0;
    end
    else
    begin
        detect <= 0;

        case(state)

            S0:
            begin
                if(din)
                    state <= S1;
                else
                    state <= S0;
            end

            S1:
            begin
                if(din)
                    state <= S1;
                else
                    state <= S2;
            end

            S2:
            begin
                if(din)
                    state <= S3;
                else
                    state <= S0;
            end

            S3:
            begin
                if(din)
                begin
                    detect <= 1;
                    state <= S1;   // Overlapping change
                end
                else
                    state <= S2;
            end

        endcase
    end
end

endmodule