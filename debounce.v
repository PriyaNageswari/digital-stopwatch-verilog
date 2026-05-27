module debounce(input clk,button, output reg clean_data);
    parameter max_count = 1000000;    //ten lakhs          // parameter is used to use a variable in a binary form
    reg [21:0]counter = 0;
    initial clean_data = 0;
    always @ (posedge clk) begin
        if(button == clean_data)
            counter <= 0;
        else begin
            if(counter == max_count)
                clean_data <= button;
            else
                counter <= counter + 1;
        end
    end  
endmodule