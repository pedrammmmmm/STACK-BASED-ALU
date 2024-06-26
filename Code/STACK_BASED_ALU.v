module STACK_BASED_ALU #(parameter N = 16, parameter STACK_SIZE = 16) (
    input wire [N-1:0] input_data,
    input wire [2:0] opcode,
    output reg [N-1:0] output_data,
    output reg overflow,
    input wire clk,
    input wire rst
);

    reg signed [N-1:0] stack [0:STACK_SIZE-1];
    reg [3:0] sp; // Stack pointer

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sp <= 0;
            output_data <= 0;
            overflow <= 0;
        end else begin
            overflow <= 0;
            case (opcode)
                3'b100: begin // Addition
                    if (sp > 1) begin
                        output_data <= stack[sp-1] + stack[sp-2];
                        // Check for overflow
                        if ((stack[sp-1] > 0 && stack[sp-2] > 0 && output_data < 0) || 
                            (stack[sp-1] < 0 && stack[sp-2] < 0 && output_data > 0)) begin
                            overflow <= 1;
                        end
                    end else begin
                        output_data <= 0;
                    end
                end

                3'b101: begin // Multiply
                    if (sp > 1) begin
                        output_data <= stack[sp-1] * stack[sp-2];
                        // Check for overflow
                        if (stack[sp-1] != 0 && output_data / stack[sp-1] != stack[sp-2]) begin
                            overflow <= 1;
                        end
                    end else begin
                        output_data <= 0;
                    end
                end

                3'b110: begin // PUSH
                    if (sp < STACK_SIZE) begin
                        stack[sp] <= input_data;
                        sp <= sp + 1;
                    end
                end

                3'b111: begin // POP
                    if (sp > 0) begin
                        sp <= sp - 1;
                        output_data <= stack[sp];
                    end else begin
                        output_data <= 0;
                    end
                end

                default: begin // No Operation for 0xx
                    output_data <= 0;
                end
            endcase
        end
    end
endmodule

