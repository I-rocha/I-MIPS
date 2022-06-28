module MI(
	// IN
	input[31:0] I,  // Endereco da instrucao
	
	// OUT
	output[31:0] ID // Instrucao
	
	);
	// # WARN: PRECISA AUMENTAR O TAMANHO DA MEMORIA NA IMPLEMENTAÇAO REAL # //
	
	reg[31:0] mem_i[31:0];  // Memoria de fato
	
	initial begin
		mem_i[0] = 32'bxxxxxx11111111100000000000001010;
		mem_i[1] = 32'bxxxxxx11111111100000000000001010;
	end
	
	assign ID = mem_i[I];   // Repassa dado do endereco I
	
endmodule
