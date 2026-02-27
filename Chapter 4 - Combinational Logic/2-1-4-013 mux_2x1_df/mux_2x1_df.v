// Dataflow description of two-to-one-line multiplexer

module mux_2x1_df (A, B, select, m_out);
	input A, B;
	input select;
	output m_out;
	
	assign m_out = (select) ? A : B; // Conditional Operator
endmodule
