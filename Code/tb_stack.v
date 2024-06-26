module testbench_s;
  //you can test for another N like 8,16,32
  //just need to change the value of N and STACK_SIZE
    parameter N = 4;
    parameter STACK_SIZE = 16;

    reg [N-1:0] input_data;
    reg [2:0] opcode;
    reg clk;
    reg rst;
    wire [N-1:0] output_data;
    wire overflow;

    STACK_BASED_ALU #(N, STACK_SIZE) uut (
        .input_data(input_data),
        .opcode(opcode),
        .output_data(output_data),
        .overflow(overflow),
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting testbench for N = %d", N);
        clk = 0;
        rst = 1;
        input_data = 0;
        opcode = 3'b000;

        #10;
        rst = 0;

        // Test PUSH
        input_data = 4;
        opcode = 3'b110;
        #10;
        input_data = 3;
        opcode = 3'b110;
        #10;

        // Test ADD (4 + 3)
        opcode = 3'b100;
        #10;

        if (output_data !== 7 || overflow !== 0) $display("Addition test failed: output_data = %d, overflow = %b", output_data, overflow);
        else $display("Addition test passed");

        // Test PUSH
        input_data = 2;
        opcode = 3'b110;
        #10;
        input_data = 6;
        opcode = 3'b110;
        #10;

        // Test MULTIPLY (6 * 2)
        opcode = 3'b101;
        #10;

        if (output_data !== 12 || overflow !== 0) $display("Multiplication test failed: output_data = %d, overflow = %b", output_data, overflow);
        else $display("Multiplication test passed");

        // Test POP
        opcode = 3'b111;
        #10;

        // Test No Operation
        opcode = 3'b000;
        #10;
    end
endmodule 


