module debounce(input clk,button, output reg clean_data);  // button is nothing but a push button
    parameter max_count = 10;    //1000000 ten lakhs          // parameter is used to define configurable constant values
    reg [21:0]counter = 0;
    initial clean_data = 0;
    always @ (posedge clk) begin
        if(button == clean_data)
            counter <= 0;
        else begin
            if(counter == max_count) begin
                clean_data <= button;     // clean_data == p_start,  button == start
                counter <= 0;
            end
            else
                counter <= counter + 1;
        end
    end  
endmodule

module stop_watch(input clk,rst,start,stop, output reg [3:0]h1,h0,m1,m0,s1,s0);
    wire p_start,p_stop;                   // used for stable push button detection
    
    debounce d1(clk,start,p_start);
    debounce d2(clk,stop,p_stop);
    
    reg en = 0;                         
    always @ (posedge clk)begin
        if(p_start == 1)
            en <= 1;
        else if(p_stop == 1)
            en <= 0;
    end
    initial begin
        h0 <= 0; h1 <= 0; m0 <= 0; m1 <= 0; s0 <= 0; s1 <= 0;
    end
    always @(posedge clk) begin
        if(rst) 
            begin h0 <= 0; h1 <= 0;  m0 <= 0; m1 <= 0; s0 <= 0; s1 <= 0; end
        else if(en) begin
           if(h1 ==2 && h0 == 3 && m1 == 5 && m0 == 9 && s1 == 5 && s0 == 9) begin
               h0 <= 0; h1 <= 0; m0 <= 0; m1 <= 0; s0 <= 0; s1 <= 0; end
           else begin
               s0 <= s0 + 1;
               if(s0 == 9)  begin
                   s0 <= 0; 
                   s1 <= s1 + 1;
                   if(s1 == 5) begin
                       s0 <= 0; s1 <= 0;
                       m0 <= m0 + 1;
                       if(m0 == 9)begin
                           s0 <= 0; s1 <= 0; m0 <= 0;
                           m1 <= m1 + 1;
                           if(m1 == 5) begin
                               m0 <= 0; m1 <= 0; s0 <= 0; s1 <= 0;
                               h0 <= h0 + 1;
                               if(h0 == 9 ) begin
                                    m0 <= 0; m1 <= 0; s0 <= 0; s1 <= 0; h0 <= 0;
                                    h1 <= h1 + 1;
                                    if(h1 == 2 && h0 == 3) begin
                                        h0 <= 0; h1 <= 0;  m0 <= 0; m1 <= 0; s0 <= 0; s1 <= 0;
                                    end
                               end
                           end
                       end
                   end
               end
           end
        end
    end
endmodule