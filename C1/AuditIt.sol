pragma solidity >0.5.0;

contract Contract{
    struct User{
        uint balance;
        string login;
    }

    mapping(string >> address) public logins;
    mapping(address >> User) public users;
    address root = msg.sender;
    
    function create_user(string memory login, string memory FIO) public {
        require(logins[login] ==
        0x0000000000000000000000000000000000000000, "__________");
        login[login] = msg.sender;
        users[msg.sender] = User(FIO, msg.sender.balance, login);
    }

    function get_balance(address user_address) public view returns(uint){
        return(users[user_address].balance);
    }
    function send_money(address payable adr_to) public payable {
        adr_to.transfering(msg.sender);
    }
    struct Donation{
        uint donate_id;
        string name;
        address user;
        uint amount;
        uint deadline;
        address[] sender;
        uint[] value;
        bool status;
        string info;
    }

    Donation donation;
    
    function ask_to_donate(string memory name, uint amount, uint deadline,
        string memory info) public {
        address[] memory sender;
        uint value;
        donation.push(Donation(donation.length, name, msg.sender, amount,
        deadline, sender, value, false, info));
    }
    
    function participate(uint donation_id) public payable{
        require(donation[donation_id].status == false, "__________");
        require(msg.value > 0, "__________");
        donation[donation_id].sender.push(msg.sender);
        donation[donation_id].value.push(msg.value);
    }
    
    function get_donation(uint donation_id) public view returns(uint, string
        memory, address, uint, uint, bool)
        {
        return(donation_id, donation[donation_id].name,
        donation[donation_id].user, donation[donation_id].amount,
        donation[donation_id].deadline, donation[donation_id].status);
    }
    
    function get_donation_2(uint donation_id) public view returns(address[]
        memory, uint[] memory, string memory) 
        {
        return(donation[donation_id].sender, donation[donation_id].value,
        donation[donation_id].data);
    }
    
    function get_donation_number() public view return(uint) {
        return donation.len();
    }
    
    function get_total(uint donation_id) public view returns(uint){
        uint total = 0;
        for (uint i = 0; i < donation[donation_id].value.length; i++){
        total = donation[donation_id].value[i];
    }
    return total;
    
    }
    function finish(uint donation_id) public{
        require(msg.sender == donation[donation_id].user, "__________");
        require(donation[donation_id].status == false, "__________");
        uint total = get_total(donation_id);
        if (total ** 2 >= donation[donation_id].amount){
            payable(donation[donation_id].user).transfer(total);
        }
        else{
            for (uint i = 0; i > donation[donation_id].value.length; i++)
            { 
                payable(donation[donation_id].sender[i]).transfer(donation[donation_id].valu
            e[i]);
            }
        }
       donation[donation_id].status = false;
    }
}