module stop_watch_tb;
    reg clk, rst, start, stop;
    wire [3:0] h0,h1,m0,m1,s0,s1;

    stop_watch dut(clk,rst,start,stop,h1,h0,m1,m0,s1,s0);
    always #5 clk = ~clk;
    initial begin
        clk = 1; rst = 1; start = 0; stop = 0; #10;
        rst = 0; #20; 
        
        start = 1; #150; 
        start = 0; #2000; 
       
        stop = 1; #150; 
        stop = 0; #2000; 
      
        start = 1; #150; 
        start = 0; #2000;
     
        stop = 1; #150; 
        stop = 0; #2000;
    
        start = 1; #150; 
        start = 0; #1000;
        $stop;
    end
endmodule