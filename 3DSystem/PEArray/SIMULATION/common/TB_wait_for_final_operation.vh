
            begin
              wait(final_operation[0].triggered) ; // we start waiting before the event will occur
              //@(final_operation[0]) ;
              //$display("@%0t LEE: Received final operation event for manager 0\n", $time);
            end
            begin
              wait(final_operation[1].triggered) ; // we start waiting before the event will occur
              //@(final_operation[1]) ;
              //$display("@%0t LEE: Received final operation event for manager 1\n", $time);
            end
            begin
              wait(final_operation[2].triggered) ; // we start waiting before the event will occur
              //@(final_operation[2]) ;
              //$display("@%0t LEE: Received final operation event for manager 2\n", $time);
            end
            begin
              wait(final_operation[3].triggered) ; // we start waiting before the event will occur
              //@(final_operation[3]) ;
              //$display("@%0t LEE: Received final operation event for manager 3\n", $time);
            end
