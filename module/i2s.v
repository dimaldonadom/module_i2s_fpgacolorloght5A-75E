//-----------------------------------------------------
// Design Name : i2s 
// File Name   : i2s.v
//-----------------------------------------------------
module i2s #(
	parameter          freq_hz = 60000000,
	parameter          resolution = 16,
    parameter          freq_music = 13000
) (
	input              rst,
	input              clk,
	// UART lines
	output reg         sck,
	output reg         sd,
    output reg         ws,
	// 
	input      [15:0]  dta,
    input              init,
	output reg         busy
);

parameter divisor = freq_hz/freq_music/resolution/4;

//-----------------------------------------------------------------
// divisor
//-----------------------------------------------------------------

reg [4:0] count16;
reg [8:0] counter;
reg [8:0] c;
reg [8:0] c2;

reg [15:0] MEM [0:511]; 
reg [15:0] A;

reg state;
reg derecho;

initial begin  // Initialize Inputs
      sck  <= 0; 
      ws   <= 0;
      c    <= 0;
      c2   <= 0;
      counter <= divisor-1;
	  derecho  <=0;
end

always @(posedge clk)
begin
	if (rst) begin

		counter  <= divisor-1;
        busy     <= 0;
		state    <= 0;
		count16  <= 0;
        ws = 0;
        sck      <= 0;
        c        <= 0;
        c2       <= 0;
		derecho  <=0;

	end else begin

		counter <= counter - 1;
        
        if(init==1)begin
            state<=1;
        end else begin
            state<=0;
        end


        if ((busy==0) && (state==0) && (init==1))begin
            c <= c+1;
            MEM[c] <= dta;

            if(c==511) begin
                busy <= 1;
            end 
        end

        if(c2==511) begin
            busy <= 0;
        end

        if (counter == 0) begin

			counter <= divisor-1;
            sck <= ~sck;

            if (sck) begin


                sd <= A[15];
                A  <= {A[14:0] , 1'b0};
                count16 <= count16 + 1;

                if (count16==15) begin

                    count16 <= 0;
                    A <= MEM[c2];
                    ws<=~ws;
					if (derecho==1)begin
						c2 <= c2 + 1;
						derecho<=0;
					end else begin
						derecho<=1;
					end
                    
                end

            end

        end
	end
end





endmodule
