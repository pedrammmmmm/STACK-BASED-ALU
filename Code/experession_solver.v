module tb_expression_solver;
    parameter N = 16;
    parameter STACK_SIZE = 16;
    reg [N-1:0] input_data;
    reg [2:0] opcode;
    reg clk;
    reg rst;
    wire [N-1:0] output_data;
    wire overflow;
    
    reg[N-1:0] res1,res2,res3;

    STACK_BASED_ALU #(N, STACK_SIZE) uut (
        .input_data(input_data),
        .opcode(opcode),
        .output_data(output_data),
        .overflow(overflow),
        .clk(clk),
        .rst(rst)
    );

    initial begin
        // Initialize clock and reset
        clk = 0;
        rst = 1;
        #10 rst = 0;

        // Push 2
        input_data = 16'd2;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Push 3
        input_data = 16'd3;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Multiply (2 * 3)
        opcode = 3'b101; // Multiply
        #10 clk = ~clk; #10 clk = ~clk;
        
        res1 = output_data;

        // Push 10
        input_data = 16'd10;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Push 4
        input_data = 16'd4;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Add (10 + 4)
        opcode = 3'b100; // Addition
        #10 clk = ~clk; #10 clk = ~clk;

        //Push 14
        input_data = output_data;
        opcode = 3'b110;
        #10 clk = ~clk; #10 clk = ~clk;
        
        // Push 3
        input_data = 16'd3;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Add (14 + 3)
        opcode = 3'b100; // Addition
        #10 clk = ~clk; #10 clk = ~clk;
        
        //Push 17
        input_data = output_data;
        opcode = 3'b110;
        #10 clk = ~clk; #10 clk = ~clk;

        // Push -20 (two's complement representation of -20 for 8-bit is 236)
        input_data = 16'hFFEC;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Multiply (17 * -20)
        opcode = 3'b101; // Multiply
        #10 clk = ~clk; #10 clk = ~clk;
        
        res2 = output_data;
        

        // Push 6
        input_data = 16'd6;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Push 5
        input_data = 16'd5;
        opcode = 3'b110; // PUSH
        #10 clk = ~clk; #10 clk = ~clk;

        // Add (6 + 5)
        opcode = 3'b100; // Addition
        #10 clk = ~clk; #10 clk = ~clk;
        
        //Push 11
        input_data = output_data;
        opcode = 3'b110;
        #10 clk = ~clk; #10 clk = ~clk;
        
        //Push 6
        input_data = res1;
        opcode = 3'b110;
        #10 clk = ~clk; #10 clk = ~clk;
        
        // Add (6 + 11)
        opcode = 3'b100; // Addition
        #10 clk = ~clk; #10 clk = ~clk;
        
        //Push 17
        input_data = output_data;
        opcode = 3'b110;
        #10 clk = ~clk; #10 clk = ~clk;
        
        //Push -340
        input_data = res2;
        opcode = 3'b110;
        #10 clk = ~clk; #10 clk = ~clk;
        
        // Add (-340 + 17)
        opcode = 3'b100; // Addition
        #10 clk = ~clk; #10 clk = ~clk;
      
    end
endmodule



