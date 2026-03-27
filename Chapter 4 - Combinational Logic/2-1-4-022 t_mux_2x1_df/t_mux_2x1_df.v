// Test bench of input test patterns for mux_2x1_df

module t_mux_2x1_df;
	wire t_mux_out;
	reg t_A, t_B;
	reg t_sel;
	parameter stop_time = 50;
	
	mux_2x1_df M1 (t_mux_out, t_A, t_B, t_sel); // Initialization of circuit for testing
	// Alternative association of ports by name:
	// mux_2x1_df M1 (.mux_out (t_mux_out), .A(t_A), .B(t_B), .sel(t_sel));
	
	initial #stop_time $finish; // Stimulus generator
		initial begin
			t_sel = 1; t_A = 0; t_B = 1;
			#10 t_A = 1; t_B = 0;
			#10 t_sel = 0;
			#10 t_A = 0; t_B = 1;
		end
		
		initial begin
			// $display ("time sel A B m_out");
			// $monitor ($time, "%b %b %b %b", t_sel, t_A, t_B, t_mux_out);
			$monitor ("time = ", $time, "t_sel = %b t_A = %b t_B = %b t_mux_out = %b", t_sel, t_A, t_B, t_mux_out);
		end
endmodule

// Data flow technology of 2-to-1 line multiplexer

module mux_2x1_df (m_out, A, B, sel);
	input A, B;
	input sel;
	output m_out;
	assign m_out = (sel) ? A : B;
endmodule

Simulation log:
	time = 0 sel = 1 A = 0 B = 1 OUT = 0
	time = 10 sel = 1 A = 1 B = 0 OUT = 1
	time = 20 sel = 0 A = 1 B = 0 OUT = 0
	time = 30 sel = 0 A = 0 B = 1 OUT = 1
