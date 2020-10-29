////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_virtual_interface
// File name    : template_virtual_interface.sv
// Description  : Template for SystemVerilog Virtual Interface facilties
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 16/10/2020
////////////////////////////////////////////////////////////////////////////////

/* SystemVerilog Dynamic Arrays
  - Arrays declared with empty size []
  - it contains no elements during declaration until explicitly defined
    using new[#elements]
  - can be resized at runtime.
  - useful when contiguous array is requires whose size changes during simulation.
  - its size during creation can be a parameter
  - can create new array intialized using existing array
  - can be queried for size and can be explictly deleted
  - value can be accessed during notation <array_name>[elem_index]
    where elem_index starts from 0
  - useful for scoreboarding: store data written to memory and then read back
    from same memory and compare with corresponding data read from memory  
*/

  logic [7:0] dynArr [];          // declare an empty dynamic array
  dynArr = new[1024];             // defined the array by creating 1024 elements
  int size = dynArr.size();       // query array size
  dynArr = new[512] (dynArr);     // resize the arry from size 1024 to 512
  dynArr.delete();                // delete elements of the dynamic array 
                                  // resetting size to 0

  logic [7:0] newDynArr;          // declare another empty dynamic array
  newDynArr = new[1024](dynArr);  // intialize new arry using elements of existing
                                  // dynamic array

  parameter num_elems = 2048;

  logic [3:0] anDynArry [];
  anDynArry = new[num_elems];

/* Associative Arrays
  - Basically dynamic array of key, value pairs
  - useful for lookup table kind of use cases with unbounded or sparse address/data space
  - key can be of any non-real type such as int, string, class etc.for which reative
    ordering can be determined i.e. any type for which SV can provide a relational
    operator.
  - For integral type, the ordering is numerical while for string type the ordering is
    lexicographical ordering. For class the ordering is arbitrary but deterministic
  - Elements stored ordered w.r.t key
  - * as key type indicates any integral type
  - it is empty during delcaration and elemnts are created upon explicit assignment
  - reading en element using a key which doesn;t yet exists returns default value 
    of the array data type.
  - has following member methods
    - num() - returns count of number of key,elem pairs in the associative array
    - delete(index) - removes key,value pair at the specified index location (starting at 0)
    - delete() - removes all key, value pairs from the associative array
    - exists(index) - returns 1 if key, value pair exists at specified index location(starting at 0)
    - next(key_index) - returns the key index in key_index next to the specified key_index. value returned is 0 if key index exists. 1 otherwise
    - prev(key_index) - returns the key index in key_index prev to the specified key_index. value returned is 0 if key index exists. 1 otherwise
    - first(key_index) - returns the key index of first key in the array in key_index. value returned is 0 if array empty. 1 otherwise.
    - last(key_index) - returns the key index of last key in the array in key_index.value returned is 0 if array empty. 1 otherwise.

*/

  bit   [1:0]   assArr1[int];        // associative array with integer key and 2-bit values
  logic [15:0]  assArr2[string] ;    // associative array with key of type and 16-bit logic value
  int           assArr3[*];          // associative array with key of any integral type

  // lookup using associative array

  logic [15:0]  assArr[int];  // empty associative array with key type integer and value type 16-bit logic
  logic [7:0]   randAddr;     // random 8-bit address
  logic [15:0]  randData;     // random 16-bit data
  logic [15:0]  readData;     // 16-bit data to be read from memory

  initial begin
    repeat(256) begin
      randomize(randAddr, randData);    // generate random address and data pair
      write(randAddr, randData);        // write the random address and data pair to memory location
      assArr[randAddr] = randData;      // store the key value pair inside associative array
      // note: it is possible that same address is generated randomly repeatedly such that
      // the random value earlier written to memory and associative array is overwritten    
    end

    $display("Number of locations stored in memory: %0d", assArr.num());

    // check the memory if all the key-values written can be read back. 
    // If yes, delete the corresponding key-value pair from associative array
    int next_index = 0;
    if( assArr.first(next_index)) begin
      do begin
        read(next_index, readData);
        if( readData != assArr[next_index])
          $display("At address  %0d, Incorrect Actual value %0d, Expected Value %0d", 
                    next_index,
                    readData,
                    assArr[next_index] );
      end
      while(assArr.next(next_index));
      
      // we delete entire array as above loop ensures all index-value pairs of associative array is iterated
      assArr.delete();
    end
  end


/* SystemVerilog Queues 
    - dynamically sized ordered collecion of elements
    - queue is useful when order of insertion and extraction are important such as FIFO and LIFO structures 
    - Unlimited sized queue: queue_data_type queue_name[$]
    - Optionally one can specify maximum queue size during delcaration: queue_data_type queue_name[$:max-size] 
    - indexed starts from 0 (front of queue) and ends in $(end of the queue)
    - has following member methods
      - size() - count of number of elements
      - insert(index, value) - inserts value at given index
      - delete(index) - removes element at given index
      - pop_front() - removes and returns the first element (index 0) from queue
      - pop_back() - removes and returns the last element (index $) from queue
      - push_front(element) - inserts element in front (index 0) of the queue
      - push_back(element) - inserts element at back (index $+1) of the queue. equivalent to insertion at location $+1.
    - cannot be deleted in single method call. instead can be set to an empty queue {}
    - reading from queue at index out of bounds returns default value of the data type of queue
    - writing to queue at index out of bounds is supressed and warning is generated
*/

int myQueue[$:128]; // empty queue with maximum size 128 locations

myQueue.push_front(1);  // {1}
myQueue.push_front(2);  // {2, 1}
myQueue.push_back(4);   // {2,1,4}
myQueue.insert(2,7);    // {2,1,7,4}
myQueue.delete(0);      // {1,7,4}
data = myQueue.pop_front(); // 1, {7,4}
data = myQueue.pop_back(); // 4, {7}
myQueue.push_back(35);      //{7,35}
myQueue.push_back(11);      //{7,35,11}
myQueue = {1,5 myQueue[0:$-1]};    //{1,5,7,35}. NOT recommended
subQueue = myQueue[1:$];  // subQueue = {5,7,35}

$display("My queue size is %0d", myQueue.size());

myQueue = {3,6,7,4,5};     // overwrite queue using an initializer
elem = myQueue[2];         // 7
myQueue = {};              // empty the queue by overwriting with empty queue initializer 


/* Methods to mainpulate Arrays */
// Searching: return queue of either elements or indexes. NOTE: cannot be applied to associative arrays with * as key type(any integral type key)
quueuGT10 = myQueue.find with (item>10);  // returns subset of elements in myQueue where every element value > 10 ? 
myQueue.find_firsy_index with (item<5); // returns index of first element in array or queue with item value < 5
myQueue.max();  // returns max value. 
myQueue.min();  // returns min value. 
myQueue.unique();  // returns only uniqe values.
myQueue.unique_index() with (item>10);  // returns indexes of elements in queueu which are unique 
myQueue.find_index with (item<=3);  //  returns all indexes of elements in queue with value <= 3



// Ordering: re-order elements of an array. NOTE cannot be applied to associative arrays
myQueue.sort(); // sorts the array or queue in ascending order with smallest value in front and largest at back of the array or queue
myQueue.rsort(); // sorts the array or queue in descending order with largest value in front and smalles at back of the array or queue

myQueue.reverse(); // reverses the array or queue. not same as reverse sort
myQueue.shuffle(); // shuffes the array or queue

// Reducing: reduce subset of elements of an array to a single value. example: sum(0, product(), and(), or(), xor(). Apply to an unpacked array
xorQvlaue = myQueue.xor; // performs xor reduction across all elements of the queue

int 2darr = {{1,1}, {0, 1}, {1,0}};
2darr.sum with {item.xor};// performs xor reduction for each unpaced sub array returning {0,1,1} and then performs sum reduction on this unpacked sub array as 2.