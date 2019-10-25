function Password_Manager()
warning('off','all');
% developed by Jason Foster, jf727@nau.edu, March 2019
% apparently I can call .NET code in MATLAB. 
sha1hasher = System.Security.Cryptography.SHA1Managed;
% initilize our databases
names = {'User_ID','username', 'password', 'h_pass', 'h_id_xor_h_pass', 'h_id_xor_Pass'};
variable = {'string','string','string','string','string','string'};
size = [20,6];
DataBase = table('Size', size, 'VariableTypes', variable);
DataBase.Properties.VariableNames = names;
size = [17,17];
variableNames = {'char','char','char','char','char','char','char','char','char','char','char','char','char','char','char','char','char'};
PasswordDatabase = table('Size', size, 'Variabletypes', variableNames);
PasswordDatabase(2,1) = {'0'};
PasswordDatabase(3,1) = {'1'};
PasswordDatabase(4,1) = {'2'};
PasswordDatabase(5,1) = {'3'};
PasswordDatabase(6,1) = {'4'};
PasswordDatabase(7,1) = {'5'};
PasswordDatabase(8,1) = {'6'};
PasswordDatabase(9,1) = {'7'};
PasswordDatabase(10,1) = {'8'};
PasswordDatabase(11,1) = {'9'};
PasswordDatabase(12,1) = {'A'};
PasswordDatabase(13,1) = {'B'};
PasswordDatabase(14,1) = {'C'};
PasswordDatabase(15,1) = {'D'};
PasswordDatabase(16,1) = {'E'};
PasswordDatabase(17,1) = {'F'};
PasswordDatabase(1,2) = {'0'};
PasswordDatabase(1,3) = {'1'};
PasswordDatabase(1,4) = {'2'};
PasswordDatabase(1,5) = {'3'};
PasswordDatabase(1,6) = {'4'};
PasswordDatabase(1,7) = {'5'};
PasswordDatabase(1,8) = {'6'};
PasswordDatabase(1,9) = {'7'};
PasswordDatabase(1,10) = {'8'};
PasswordDatabase(1,11) = {'9'};
PasswordDatabase(1,12) = {'A'};
PasswordDatabase(1,13) = {'B'};
PasswordDatabase(1,14) = {'C'};
PasswordDatabase(1,15) = {'D'};
PasswordDatabase(1,16) = {'E'};
PasswordDatabase(1,17) = {'F'};
User = 1;
while(true)
   % Are we creating a new account?
   new = input('type y if you want to make a new account, otherwise push any button to continue:    ', 's');
   if strcmpi('q',new) == 1
       break
   end
   % create new account
    if strcmpi(new,'y') == 1
        while(true)
        username = input('Enter Your Desired Username:    ', 's');
        password = input('Enter Your Desired Password:    ', 's');
        % It would suck if you made a typo on this step, huh?
        username2 = input('Enter Your Username Again:    ', 's');
        password2 = input('Enter Your Password Again:    ', 's');
        if strcmp(username,username2) == 0
           disp('ERROR: Usernames Dont Match');
           continue
        elseif strcmp(password,password2) == 0
           disp('ERROR: Passwords Dont Match');
           continue
        else
           %Store password in databases
           passhash = uint64(sha1hasher.ComputeHash(uint8(password)));
           userhash = uint64(sha1hasher.ComputeHash(uint8(username)));
           A = dec2hex(passhash);
           C = dec2hex(userhash);
           B = '';
           for i = 1:20
                B = [B,A(i,1:2)];
           end
           DataBase(User,1) = {User};
           puhash = bitxor(passhash,userhash);
           puhashhex = dec2hex(puhash);
           D = '';
           for i = 1:20
               D = [D, puhashhex(i,1:2)];
           end
           address = D(1:2);
           DataBase(User,2) = {username};
           DataBase(User,3) = {password};
           DataBase(User,4) = {B};
           DataBase(User,5) = {D};
           E = uint64(sha1hasher.ComputeHash(uint8(password)));
           EE = dec2hex(E);
           H = '';
           for i = 1:20
               H = [H, EE(i,1:2)];
           end
           DataBase(User,6) = {H};
           User = User + 1;
           PasswordDatabase(2+hex2dec(address(1)),2+hex2dec(address(2))) = {B};
           disp('account created successfully');
           DataBase
           PasswordDatabase
           break
        end
        end
    else
       % Well we arent making a new account so lets get those login credentials
       username = input('Enter Your Username:    ', 's');
       password = input('Enter Your Password:    ', 's');
       % Is there a username/password pair here?
       passhash = uint64(sha1hasher.ComputeHash(uint8(password)));
       userhash = uint64(sha1hasher.ComputeHash(uint8(username)));
       A = dec2hex(passhash);
       C = dec2hex(userhash);
       B = '';
       for i = 1:20
            B = [B,A(i,1:2)];
       end
       puhash = bitxor(passhash,userhash);
       puhashhex = dec2hex(puhash);
       D = '';
       for i = 1:20
           D = [D, puhashhex(i,1:2)];
       end
       address = D(1:2);
       E = uint64(sha1hasher.ComputeHash(uint8(password)));
       EE = dec2hex(E);
       H = '';
       for i = 1:20
           H = [H, EE(i,1:2)];
       end
       TestB = PasswordDatabase(2+hex2dec(address(1)),2+hex2dec(address(2)));
       TestB = TestB{1,1};
       TestB = TestB{1};
       if strcmp(TestB,B)
            disp(string(username) + ' has been signed in');
            while(true)
                edits = input('Press c for a password change, q to quit, or d to delete account:   ', 's');
                if strcmpi(edits, 'q') == 1
                    break
                end
                for i = 1:User
                    searching = DataBase(i,2);
                    searching = searching{1,1};
                    searching = searching{1};
                    if strcmp(searching,string(username))
                        ID = DataBase(i,1);
                        ID = ID{1,1};
                        ID = ID{1};
                        ID = str2num(ID);
                        break
                    end
                end
                if strcmpi(edits, 'c') == 1
                    PasswordDatabase(2+hex2dec(address(1)),2+hex2dec(address(2))) = {''};
                    while(true)
                        newpassword = input('Enter your new password:    ', 's');
                        NEWPASSWORD = input('Enter your new password:    ', 's');
                        if strcmp(newpassword, NEWPASSWORD) == 0
                            disp('ERROR: Passwords dont match');
                            continue
                        end
                    passhash = uint64(sha1hasher.ComputeHash(uint8(newpassword)));
                    userhash = uint64(sha1hasher.ComputeHash(uint8(username)));
                    A = dec2hex(passhash);
                    C = dec2hex(userhash);
                    B = '';
                    for i = 1:20
                        B = [B,A(i,1:2)];
                    end
                    puhash = bitxor(passhash,userhash);
                    puhashhex = dec2hex(puhash);
                    D = '';
                    for i = 1:20
                       D = [D, puhashhex(i,1:2)];
                    end
                    address = D(1:2);
                    DataBase(ID,3) = {newpassword};
                    DataBase(ID,4) = {B};
                    DataBase(ID,5) = {D};
                    E = uint64(sha1hasher.ComputeHash(uint8(newpassword)));
                    EE = dec2hex(E);
                    H = '';
                    for i = 1:20
                        H = [H, EE(i,1:2)];
                    end
                    DataBase(ID,6) = {H};
                    PasswordDatabase(2+hex2dec(address(1)),2+hex2dec(address(2))) = {B};
                    disp('Password Changed successfully');
                    DataBase
                    PasswordDatabase
                    break
                    end
                elseif strcmpi(edits, 'd') == 1
                    PasswordDatabase(2+hex2dec(address(1)),2+hex2dec(address(2))) = {''};
                    DataBase(ID,1) = {''};
                    DataBase(ID,2) = {''};
                    DataBase(ID,3) = {''};
                    DataBase(ID,4) = {''};
                    DataBase(ID,5) = {''};
                    DataBase(ID,6) = {''};
                    User = User - 1;
                    disp('Account deleted successfully'); 
                    PasswordDatabase
                    DataBase
                    break
                else
                    continue
                end
            end
       else
           disp('ERROR: Login failed');
       end
       continue
    end
end
end