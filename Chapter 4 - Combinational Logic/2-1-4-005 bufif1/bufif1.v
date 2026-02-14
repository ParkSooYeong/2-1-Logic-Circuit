// Mux with 3-state output
module mux_tri(m_out, A, B, select);
	input A, B, select;
	output m_out;
	tri m_out;
	
	bufif1(m_out, A, select);
	bufif0(m_out, B, select);
endmodule
