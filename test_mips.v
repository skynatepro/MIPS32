`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:23:06 04/06/2022
// Design Name:   mips32
// Module Name:   E:/RISC32/mips32/test_mips.v
// Project Name:  mips32
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mips;

	// Inputs
	reg clk1;
	reg clk2;
	integer k;
	// Instantiate the Unit Under Test (UUT)
	mips32 mips (.clk1(clk1), .clk2(clk2));

	initial
		begin
			clk1 = 0; clk2 = 0;
			repeat(20)
				begin
					#clk1 = 1; clk2 = 0;
					#clk1 = 1; clk2 = 0;
				end
		end
	initial
		begin
			for(k=0;k<31;k++)
				mips.Regbank[k] = k;
			mips.Mem[0] = 32'h2801000a;  //ADDI R1, R0, 10
			mips.Mem[1] = 32'h28020014;  //ADDI R2, R0, 20
			mips.Mem[2] = 32'h28030019;  //ADDI R3, R0, 25
			mips.Mem[3] = 32'h0ce77800;  //OR	R7, R7, R7 -- Dummy
			mips.Mem[4] = 32'h0ce77800;  //OR	R7, R7, R7 -- Dummy
			mips.Mem[5] = 32'h00222000;  //ADD  R4, R1, R2
			mips.Mem[6] = 32'h0ce77800;  //OR	R7, R7, R7 -- Dummy
			mips.Mem[7] = 32'h00832800;  //ADD  R5, R4, R3
			mips.Mem[8] = 32'hfc000000;  //HLT
			
			mips.HALTED = 0;
			mips.PC 		= 0;
			//mips.TAKEN_BRANCH = 0;
			
			#280
			for(k=0; k<6; k++)
				$display("R%1d-%2d", k, mips.Regbank[k]);
			end
	initial
		begin
			$dumpfile("mips.vcd");
			$dumpfile(0, test_mips);
			#300 $finish;
		end
endmodule

