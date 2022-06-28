module interfaceGeral(
	
	//input start,   // Controle de inicio de variavel
	input clk,              // TIMER
	
	input[31:0] instr_addr, // Instrução
	input immop,            // Sinal de escolha Imediato
	input[ 4:0] aluop,      // Sinal da ULA
	input memw,             // Escrita na memoria
	input[ 1:0] regw,        // Escrita no banco
	input cdataop,          // Controle de mux DataOp
	input cdatast,	         // Controle mux DataStore
	
	output[31:0] id,        // Instrução de fato
	output[31:0] outd1,     // Dado em reg1
	//output[31:0] outd2,	   // Dado em reg2
	output[31:0] outr1,     // Resultado ULA
	//output[31:0] outimm,  // Imediato da instrução
	output[31:0] outdm      // Memoria de dados out
);
	
	
	// MI - Sign Extend out
	wire[15:0] imm16;
	wire[31:0] imm32;
	
	// BR IN
	//reg[31:0] dr1_;
	reg[31:0] dj;
	//reg[ 4:0] ra1, ra2;
	//reg[ 1:0] ew;
	reg df;
	wire[31:0] dr1_;
	
	// BR OUT
	wire[31:0] dr1, dr2;
	wire cfl;
	
	// ULAS IN
	wire[31:0] op2;
	reg[ 4:0] smt;
	//reg[ 4:0] aluop;
	
	// ULAS OUT
	wire[31:0] r1;
	wire uf;
	
	// MEM OUT
	wire[31:0] dm;
	
	
	//always @(start) begin
		//aluop = 5'b00001;
		//ra1 = 5'b11111;  // 31
		//ra2 = 5'b11110;  // 30
		
		//smt =  5'b00000
		
	//end
	
	// Memoria de instrução
	MI mi(.I(instr_addr), .ID(id));
	
	// Banco de reg
	BR br0(.DR1_(dr1_), .DJ(dj), .RA1(id[25:21]), .RA2(id[20:16]), .EW(regw), .DF(df), .DR1(dr1), .DR2(dr2), .CFL(cfl), .clk(clk));
	
	// Mux escolha do imediato dado o formato de instrução
	mux2b16 mximmop(.in0(id[15:0]), .in1(id[20:5]), .c(immop), .out(imm16));
	
	// Extensor 16->32
	signExtend signextend0(.in(imm16), .out(imm32));
	
	// Mux operando 2 da ULA
	mux2b32 mxdataop(.in0(imm32), .in1(dr2), .c0(cdataop),.out(op2));
	
	// ULA
	ULAS ulas0( .op1(dr1), .op2(op2), .smt(smt), .aluop(aluop), .r1(r1), .UF(uf));
	
	// Memória de dados
	MD md0(.AM(r1), .DM_(dr2), .EW(memw), .DM(dm), .clk(clk));
	
		// Mux de escrita nos regs
	mux2b32 mxdatast(.in0(dm), .in1(r1), .c0(cdatast), .out(dr1_));
	
	assign outd1 = dr1;
	//assign outd2 = dr2;
	assign outr1 = r1;
	//assign outimm = imm32;
	assign outdm = dm;
endmodule
