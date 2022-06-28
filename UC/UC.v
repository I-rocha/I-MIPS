module UC(
	
	// IN
	input[5:0] opcode,
	input[4:0] funct,
	
	// OUT
	output[1:0] regw,
	output immop,
	output dataop,
	output datast,
	output[4:0] aluop,
	output memw,
	output cond,
	output jump,
	output branch
);
	
	reg[13:0] out;

	always @* begin
		case (opcode)
		6'b000001 : 
		begin 
			case (funct)
			5'b00001 : begin out = 14'b11x11000010000; end
			5'b00010 : begin out = 14'b11x11000100000; end
			5'b00011 : begin out = 14'b11101000010000; end
			5'b00100 : begin out = 14'b11101000100000; end
			default : begin out = 14'b00xxxxxxxx0000; end	// NOP
			endcase
		end
		6'b000010 : begin 
			case (funct)
			5'b00001 : begin out = 14'b11x11000110000; end
			5'b00010 : begin out = 14'b11x11001000000; end
			5'b00011 : begin out = 14'b11xx1001010000; end
			5'b00100 : begin out = 14'b11x11001100000; end
			5'b00101 : begin out = 14'b11101000110000; end
			5'b00110 : begin out = 14'b11101001000000; end
			5'b00111 : begin out = 14'b11101001010000; end
			5'b01000 : begin out = 14'b11101001100000; end
			5'b01001 : begin out = 14'b11xx1001110000; end
			5'b01010 : begin out = 14'b11xx1010000000; end
			default : begin out = 14'b00xxxxxxxx0000; end	// NOP
			endcase
		end
		6'b000011 : begin 
			case (funct)
			5'b00001 : begin out = 14'b00x1x010010000; end
			5'b00010 : begin out = 14'b00x1x010100000; end
			5'b00011 : begin out = 14'b00x1x010110000; end
			5'b00100 : begin out = 14'b00x1x011000000; end
			5'b00101 : begin out = 14'b00x1x011010000; end
			5'b00110 : begin out = 14'b00x1x011100000; end
			5'b00111 : begin out = 14'b0010x010010000; end
			5'b01000 : begin out = 14'b0010x010100000; end
			5'b01001 : begin out = 14'b0010x010110000; end
			5'b01010 : begin out = 14'b0010x011000000; end
			5'b01011 : begin out = 14'b0010x011010000; end
			5'b01100 : begin out = 14'b0010x011100000; end
			default: begin out = 14'b00xxxxxxxx0000; end
			endcase
		end
		6'b000100 : begin out = 14'b11x11000000000; end
		6'b000101 : begin out = 14'b0000x000011000; end
		6'b000110 : begin out = 14'b11000000010000; end
		6'b000111 : begin out = 14'b11101000000000; end
		6'b001000 : begin out = 14'b11101000000000; end
		6'b001001 : begin out = 14'b00xxxxxxxx0010; end
		6'b001010 : begin out = 14'b10xxxxxxxx0010; end
		6'b001011 : begin out = 14'b00xxxxxxxx0110; end
		6'b001100 : begin out = 14'b000xxxxxxx0001; end
		6'b001101 : begin out = 14'b100xxxxxxx0001; end
		6'b001110 : begin out = 14'b000xxxxxxx0101; end
		default : begin out = 14'b00xxxxxxxx0000; end
		endcase
	end
	
	assign regw[1] = out[13];
	assign regw[0] = out[12];
	assign immop = out[11];
	assign dataop = out[10];
	assign datast = out[9];
	assign aluop[4] = out[8];
	assign aluop[3] = out[7];
	assign aluop[2] = out[6];
	assign aluop[1] = out[5];
	assign aluop[0] = out[4];
	assign memw = out[3];
	assign cond = out[2];
	assign jump = out[1];
	assign branch = out[0];

endmodule
