http = require("socket.http")
https = require("ssl.https")
JSON = dofile("./lib/dkjson.lua")
json = dofile("./lib/JSON.lua")
URL = dofile("./lib/url.lua")
serpent = dofile("./lib/serpent.lua")
redis = dofile("./lib/redis.lua").connect("127.0.0.1", 6379)
Server_Devid = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
------------------------------------------------------------------------------------------------------------
local function Load_File()
local f = io.open("./Info_Sudo.lua", "r")  
if not f then   
if not redis:get(Server_Devid.."Token_Devbot") then
io.write('\n\27[1;35m⬇┇Send Token For Bot : ارسل توكن البوت ...\n\27[0;39;49m')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m🔄┇Token Is Communication Error\n التوكن غلط جرب مره اخره \n\27[0;39;49m')
else
io.write('\n\27[1;31m• Done Save Token : تم حفظ التوكن \n\27[0;39;49m')
redis:set(Server_Devid.."Token_Devbot",token)
end 
else
io.write('\n\27[1;31m🔄┇Token was not saved \n لم يتم حفظ التوكن \n\27[0;39;49m')
end 
os.execute('lua FDFGERB.lua')
end
------------------------------------------------------------------------------------------------------------
if not redis:get(Server_Devid.."User_Devbots1") then
io.write('\n\27[1;35m⬇┇Send UserName For Sudo : ارسل معرف المطور الاساسي ...\n\27[0;39;49m')
local User_Sudo = io.read()
if User_Sudo ~= '' then
io.write('\n\27[1;31m• The UserNamr Is Saved : تم حفظ معرف المطور واستخراج ايدي المطور\n\27[0;39;49m')
redis:set(Server_Devid.."User_Devbots1",User_Sudo)
else
io.write('\n\27[1;31m🔄┇The UserName was not Saved : لم يتم حفظ معرف المطور الاساسي\n\27[0;39;49m')
end 
os.execute('lua FDFGERB.lua')
end
if not redis:get(Server_Devid.."Id_Devbotsid") then
io.write('\n\27[1;35m⬇┇Send id For Sudo : ارسل ايدي المطور الاساسي ...\n\27[0;39;49m')
local User_Sudo = io.read()
if User_Sudo ~= '' then
io.write('\n\27[1;31m• The id Is Saved : تم حفظ ايدي المطور واستخراج ايدي المطور\n\27[0;39;49m')
redis:set(Server_Devid.."Id_Devbotsid",User_Sudo)
else
io.write('\n\27[1;31m🔄┇The id was not Saved : لم يتم حفظ ايدي المطور الاساسي\n\27[0;39;49m')
end 
os.execute('lua FDFGERB.lua')
end
------------------------------------------------------------------------------------------------------------
local Dev_Info_Sudo = io.open("Info_Sudo.lua", 'w')
Dev_Info_Sudo:write([[
do 
local File_Info = {
id_dev = ]]..redis:get(Server_Devid.."Id_Devbotsid")..[[,
UserName_dev = "]]..redis:get(Server_Devid.."User_Devbots1")..[[",
Token_Bot = "]]..redis:get(Server_Devid.."Token_Devbot")..[["
}
return File_Info
end

]])
Dev_Info_Sudo:close()
------------------------------------------------------------------------------------------------------------
local Run_File_FDFGERB = io.open("FDFGERB", 'w')
Run_File_FDFGERB:write([[
#!/usr/bin/env bash
cd $HOME/FDFGERB
token="]]..redis:get(Server_Devid.."Token_Devbot")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./FDFGERB.lua -p PROFILE --bot=$token
done
]])
Run_File_FDFGERB:close()
------------------------------------------------------------------------------------------------------------
local Run_SM = io.open("NG", 'w')
Run_SM:write([[
#!/usr/bin/env bash
cd $HOME/FDFGERB
while(true) do
rm -fr ../.telegram-cli
screen -S FDFGERB -X kill
screen -S FDFGERB ./FDFGERB
done
]])
Run_SM:close()
io.popen("mkdir Files")
os.execute('chmod +x tg')
os.execute('chmod +x NG')
os.execute('chmod +x FDFGERB')
os.execute('./NG')
Status = true
else   
f:close()  
redis:del(Server_Devid.."Token_Devbot");redis:del(Server_Devid.."Id_Devbotsid");redis:del(Server_Devid.."User_Devbots1")
Status = false
end  
return Status
end
Load_File()
------------------------------------------------------------------------------------------------------------
sudos = dofile("./Info_Sudo.lua")
token = sudos.Token_Bot
UserName_Dev = sudos.UserName_dev
bot_id = token:match("(%d+)")  
Id_Dev = sudos.id_dev
Ids_Dev = {sudos.id_dev,373906612}
Name_Bot = (redis:get(bot_id.."FDFGERB:Redis:Name:Bot") or "FDFGERB")
------------------------------------------------------------------------------------------------------------
function var(value)  
print(serpent.block(value, {comment=false}))   
end 
function dl_cb(arg,data)
-- var(data)  
end
------------------------------------------------------------------------------------------------------------
function Bot(msg)  
local idbot = false  
if msg.sender_user_id_ == bot_id then  
idbot = true  
end  
return idbot  
end 
function Dev_Bots(msg)  
local Dev_Bots = false  
for k,v in pairs(Ids_Dev) do  
if msg.sender_user_id_ == v then  
Dev_Bots = true  
end  
end  
return Dev_Bots  
end 
function Dev_Bots_User(user)  
local Dev_Bots_User = false  
for k,v in pairs(Ids_Dev) do  
if user == v then  
Dev_Bots_User = true  
end  
end  
return Dev_Bots_User  
end 
function DeveloperBot1(msg) 
local Status = redis:sismember(bot_id.."FDFGERB:Developer:Bot", msg.sender_user_id_) 
if Status or Dev_Bots(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
function DeveloperBot(msg) 
local Status = redis:sismember(bot_id.."FDFGERB:Developer:Bot", msg.sender_user_id_) 
if Status or Dev_Bots(msg) or DeveloperBot1(msg) or Bot(msg) then    
return true  
else  
return false  
end  
end
function PresidentGroup(msg)
local hash = redis:sismember(bot_id.."FDFGERB:President:Group"..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or Bot(msg) then    
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = redis:sismember(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Owner(msg)
local hash = redis:sismember(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Admin(msg)
local hash = redis:sismember(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_,msg.sender_user_id_)    
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Bot(msg) then       
return true    
else    
return false    
end 
end
function Vips(msg)
local hash = redis:sismember(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_,msg.sender_user_id_) 
if hash or Dev_Bots(msg) or DeveloperBot1(msg) or DeveloperBot(msg) or PresidentGroup(msg) or Constructor(msg) or Owner(msg) or Admin(msg) or Bot(msg) then       
return true 
else 
return false 
end 
end
------------------------------------------------------------------------------------------------------------
function Rank_Checking(user_id,chat_id)
if Dev_Bots_User(user_id) then
Status = true  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = true  
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot1", user_id) then
Status = true  
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot", user_id) then
Status = true  
elseif redis:sismember(bot_id.."FDFGERB:President:Group"..chat_id, user_id) then
Status = true
elseif redis:sismember(bot_id..'FDFGERB:Constructor:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'FDFGERB:Manager:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'FDFGERB:Admin:Group'..chat_id, user_id) then
Status = true  
elseif redis:sismember(bot_id..'FDFGERB:Vip:Group'..chat_id, user_id) then  
Status = true  
else  
Status = false  
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function Get_Rank(user_id,chat_id)
if Dev_Bots_User(user_id) == true then
Status = "المطور الاساسي"  
elseif tonumber(user_id) == tonumber(bot_id) then  
Status = "البوت"
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot1", user_id) then
Status = redis:get(bot_id.."FDFGERB:Developer:Bot:Reply"..chat_id) or "المطور1"  
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot", user_id) then
Status = redis:get(bot_id.."FDFGERB:Developer:Bot:Reply"..chat_id) or "المطور"  
elseif redis:sismember(bot_id.."FDFGERB:President:Group"..chat_id, user_id) then
Status = redis:get(bot_id.."FDFGERB:President:Group:Reply"..chat_id) or "المنشئ اساسي"
elseif redis:sismember(bot_id..'FDFGERB:Constructor:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."FDFGERB:Constructor:Group:Reply"..chat_id) or "المنشئ"  
elseif redis:sismember(bot_id..'FDFGERB:Manager:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."FDFGERB:Manager:Group:Reply"..chat_id) or "المدير"  
elseif redis:sismember(bot_id..'FDFGERB:Admin:Group'..chat_id, user_id) then
Status = redis:get(bot_id.."FDFGERB:Admin:Group:Reply"..chat_id) or "الادمن"  
elseif redis:sismember(bot_id..'FDFGERB:Vip:Group'..chat_id, user_id) then  
Status = redis:get(bot_id.."FDFGERB:Vip:Group:Reply"..chat_id) or "المميز"  
else  
Status = redis:get(bot_id.."FDFGERB:Mempar:Group:Reply"..chat_id) or "العضو"
end  
return Status
end 
------------------------------------------------------------------------------------------------------------
function ChekBotAdd(chat_id)
if redis:sismember(bot_id.."FDFGERB:ChekBotAdd",chat_id) then
Status = true
else 
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function MutedGroups(Chat_id,User_id) 
if redis:sismember(bot_id.."FDFGERB:Silence:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function RemovalUserGroup(Chat_id,User_id) 
if redis:sismember(bot_id.."FDFGERB:Removal:User:Group"..Chat_id,User_id) then
Status = true
else
Status = false
end
return Status
end 
------------------------------------------------------------------------------------------------------------
function RemovalUserGroups(User_id) 
if redis:sismember(bot_id.."FDFGERB:Removal:User:Groups",User_id) then
Status = true
else
Status = false
end
return Status
end
function SilencelUserGroups(User_id) 
if redis:sismember(bot_id.."FDFGERB:Silence:User:Groups",User_id) then
Status = true
else
Status = false
end
return Status
end
------------------------------------------------------------------------------------------------------------
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
------------------------------------------------------------------------------------------------------------
function Delete_Message(chat,id)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil))
end
------------------------------------------------------------------------------------------------------------
function DeleteMessage_(chat,id,func)
pcall(tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function getInputFile(file) 
if file:match("/") then 
infile = {ID = "InputFileLocal", 
path_ = file} 
elseif file:match("^%d+$") then 
infile = {ID = "InputFileId", 
id_ = file} 
else infile = {ID = "InputFilePersistentId", 
persistent_id_ = file} 
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function RestrictChat(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
------------------------------------------------------------------------------------------------------------
function Get_Api(Info_Web) 
local Info, Res = https.request(Info_Web) 
local Req = json:decode(Info) 
if Res ~= 200 then 
return false 
end 
if not Req.ok then 
return false 
end 
return Req 
end 
------------------------------------------------------------------------------------------------------------
function sendText(chat_id, text, reply_to_message_id, markdown) 
Status_Api = "https://api.telegram.org/bot"..token 
local Url_Api = Status_Api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
Url_Api = Url_Api .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
Url_Api = Url_Api.."&parse_mode=Markdown" 
elseif markdown == "html" then 
Url_Api = Url_Api.."&parse_mode=HTML" 
end 
return Get_Api(Url_Api)  
end
------------------------------------------------------------------------------------------------------------
function send_inline_keyboard(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local Status_Api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
Status_Api = Status_Api.."&reply_to_message_id="..reply_id 
end 
return Get_Api(Status_Api) 
end
------------------------------------------------------------------------------------------------------------
function GetInputFile(file)  
local file = file or ""   
if file:match("/") then  
infile = {ID= "InputFileLocal", path_  = file}  
elseif file:match("^%d+$") then  
infile ={ID="InputFileId",id_=file}  
else infile={ID="InputFilePersistentId",persistent_id_ = file}  
end 
return infile 
end
------------------------------------------------------------------------------------------------------------
function sendPhoto(chat_id,reply_id,photo,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ""
}
},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendVoice(chat_id,reply_id,voice,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = "",
waveform_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAnimation(chat_id,reply_id,animation,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendAudio(chat_id,reply_id,audio,title,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = "",
title_ = title or "",
performer_ = "",
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendSticker(chat_id,reply_id,sticker,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendVideo(chat_id,reply_id,video,caption,func)
pcall(tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ""
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function sendDocument(chat_id,reply_id,document,caption,func)
pcall(tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil))
end
------------------------------------------------------------------------------------------------------------
function KickGroup(chat,user)
pcall(tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil))
end
------------------------------------------------------------------------------------------------------------
function Send_Options(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "tahaj20")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch
end
if status == "Close_Status" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."")
return false
end
if status == "Close_Status_Ktm" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n• خاصية ← الكتم\n")
return false
end
if status == "Close_Status_Kick" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n• خاصية ← الطرد\n")
return false
end
if status == "Close_Status_Kid" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text.."\n• خاصية ← التقييد\n")
return false
end
if status == "Open_Status" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply" then
send(msg.chat_id_, msg.id_,"• المستخدم ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
if status == "reply_Add" then
send(msg.chat_id_, msg.id_,"• بواسطه ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"•  لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
function Send_Optionspv(chat,idmsg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "tahaj20")
for gmatch in string.gmatch(data.first_name_, "[^%s]+") do
data.first_name_ = gmatch
end
if status == "reply_Pv" then
send(chat,idmsg,"• المستخدم ← ["..data.first_name_.."](T.me/"..UserName..")".."\n"..text)
return false
end
else
send(chat,idmsg,"•  لا يمكن الوصول لمعلومات الشخص")
end
end,nil)   
end
------------------------------------------------------------------------------------------------------------
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'تفاعل محلو 😤' 
elseif tonumber(Message) < 200 then 
MsgText = 'تفاعلك ضعيف ليش'
elseif tonumber(Message) < 400 then 
MsgText = 'عفيه اتفاعل 😽' 
elseif tonumber(Message) < 700 then 
MsgText = 'شكد تحجي😒' 
elseif tonumber(Message) < 1200 then 
MsgText = 'ملك التفاعل 😼' 
elseif tonumber(Message) < 2000 then 
MsgText = 'موش تفاعل غنبله' 
elseif tonumber(Message) < 3500 then 
MsgText = 'اساس لتفاعل ياب'  
elseif tonumber(Message) < 4000 then 
MsgText = 'عوف لجواهر وتفاعل بزودك' 
elseif tonumber(Message) < 4500 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(Message) < 5500 then 
MsgText = 'شهلتفاعل استمر يكيك' 
elseif tonumber(Message) < 7000 then 
MsgText = 'غنبله وربي 🌟' 
elseif tonumber(Message) < 9500 then 
MsgText = 'حلغوم مال تفاعل' 
elseif tonumber(Message) < 10000000000 then 
MsgText = 'تفاعل نار وشرار'  
end 
return MsgText 
end
------------------------------------------------------------------------------------------------------------
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
------------------------------------------------------------------------------------------------------------
function NotSpam(msg,Type)
if Type == "kick" then 
Send_Options(msg,msg.sender_user_id_,"reply","• قام بالتكرار هنا وتم طرده")  
KickGroup(msg.chat_id_,msg.sender_user_id_) 
return false  
end 
if Type == "del" then 
Delete_Message(msg.chat_id_,{[0] = msg.id_})    
return false
end 
if Type == "keed" then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_) 
Send_Options(msg,msg.sender_user_id_,"reply","• قام بالتكرار هنا وتم تقييده")  
return false  
end  
if Type == "mute" then
Send_Options(msg,msg.sender_user_id_,"reply","• قام بالتكرار هنا وتم كتمه")  
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_) 
return false  
end
end  
------------------------------------------------------------------------------------------------------------
function GetFile_Bot(msg)
local list = redis:smembers(bot_id..'FDFGERB:ChekBotAdd') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'FDFGERB Chat'
link = redis:get(bot_id.."FDFGERB:link:set:Group"..msg.chat_id_) or ''
ASAS = redis:smembers(bot_id..'FDFGERB:President:Group'..v)
MNSH = redis:smembers(bot_id..'FDFGERB:Constructor:Group'..v)
MDER = redis:smembers(bot_id..'FDFGERB:Manager:Group'..v)
MOD = redis:smembers(bot_id..'FDFGERB:Admin:Group'..v)
if k == 1 then
t = t..'"'..v..'":{"FDFGERB":"'..NAME..'",'
else
t = t..',"'..v..'":{"FDFGERB":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_, './'..bot_id..'.json','• عدد مجموعات التي في البوت { '..#list..'}')  
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"• ملف نسخه ليس لهذا البوت")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," جاري ...\n رفع الملف الان")
else
send(chat,msg.id_,"*• عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")   
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
redis:sadd(bot_id..'FDFGERB:ChekBotAdd',idg)  
redis:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
redis:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
redis:sadd(bot_id..'FDFGERB:Constructor:Group'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
redis:sadd(bot_id..'FDFGERB:Manager:Group'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
redis:sadd(bot_id..'FDFGERB:Admin:Group'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
redis:sadd(bot_id..'FDFGERB:President:Group'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n•تم رفع الملف بنجاح وتفعيل المجموعات\n• ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح")   
end
function AddChannel(User)
local var = true
if redis:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..redis:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

------------------------------------------------------------------------------------------------------------
function Dev_Bots_File(msg,data)
if msg then
msg = data.message_
text = msg.content_.text_
------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
redis:incr(bot_id..'FDFGERB:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) 
TypeForChat = 'ForSuppur' 
elseif id:match("^(%d+)") then
redis:sadd(bot_id..'FDFGERB:Num:User:Pv',msg.sender_user_id_)  
TypeForChat = 'ForUser' 
else
TypeForChat = 'ForGroup' 
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Lock:text"..msg.chat_id_) and not Vips(msg) then       
Delete_Message(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(bot_id.."FDFGERB:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Vips(msg) then   
if redis:get(bot_id.."FDFGERB:Lock:AddMempar"..msg.chat_id_) == "kick" then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
KickGroup(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Vips(msg) then 
if redis:get(bot_id.."FDFGERB:Lock:Join"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "del" and not Vips(msg) then    
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "ked" and not Vips(msg) then    
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "kick" and not Vips(msg) then    
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "ktm" and not Vips(msg) then    
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Vips(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Vips(msg) then
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "del" and not Vips(msg) then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "ked" and not Vips(msg) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "kick" and not Vips(msg) then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "ktm" and not Vips(msg) then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessagePhoto" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVideo" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAnimation" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageAudio" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageVoice" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageSticker" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageDocument" and not Vips(msg) then     
if redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Vips(msg) then      
if redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Vips(msg) then
if redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 

if tonumber(msg.via_bot_user_id_) ~= 0 and not Vips(msg) then
if redis:get(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageContact" and not Vips(msg) then      
if redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "del" then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "ked" then
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "kick" then
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "ktm" then
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Vips(msg) then  
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
RestrictChat(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
KickGroup(msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
elseif redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,msg.sender_user_id_)
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
end
end
------------------------------------------------------------------------------------------------------
local status_welcome = redis:get(bot_id.."FDFGERB:Chek:Welcome"..msg.chat_id_)
if status_welcome and not redis:get(bot_id.."FDFGERB:Lock:tagservr"..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = redis:get(bot_id.."FDFGERB:Get:Welcome:Group"..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = "\n• نورت حبي \n•  name \n• user" 
end 
t = t:gsub("name",result.first_name_) 
t = t:gsub("user",("@"..result.username_ or "لا يوجد")) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
if text and redis:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Manager(msg) then 
list = {"خول","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and redis:get(bot_id..'lock:emoje'..msg.chat_id_) and not Manager(msg) then 
list = {"😀","😃","😄","😁","😆","😅","😂 ","🤣","☺️","😊","😇","🙂","🙃","😉","😌","😍","🥰","😘","😗","😙","😚","😋","😛","😝","😜","😜","🤪","🤨","🧐","🤓","😎","🤩","🥳","😏","😒","😞","😔","😟","😕","🙁","☹️","😣","😖","😫","🥺","😢","😭","😤","😠","😡","🤬","🤯","😳","🥵","🥶","😱","😨","😰","😥","😓","🤗","🤔","🤭","🤫","🤥","😶","😐","😑","😬","🙄","😯","😦","😧","😮","😲","🥱","😴","🤤","😪","🤤","😵","🤠","🤑","🤕","🤒","😷","🤮","😷","🤢","🥴"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
Delete_Message(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
-------------------------------------------------------
if msg.content_.ID == "MessagePinMessage" then
if Constructor(msg) or tonumber(msg.sender_user_id_) == tonumber(bot_id) then 
redis:set(bot_id.."FDFGERB:Get:Id:Msg:Pin"..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = redis:get(bot_id.."FDFGERB:Get:Id:Msg:Pin"..msg.chat_id_)
if Msg_Pin and redis:get(bot_id.."FDFGERB:lockpin"..msg.chat_id_) then
Pin_Message(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if not Vips(msg) and msg.content_.ID ~= "MessageChatAddMembers" and redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Spam:User") then 
if msg.sender_user_id_ ~= bot_id then
floods = redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Spam:User") or "nil"
Num_Msg_Max = redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
Time_Spam = redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 5
local post_count = tonumber(redis:get(bot_id.."FDFGERB:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_) or 0)
if post_count > tonumber(redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5) then 
local ch = msg.chat_id_
local type = redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Spam:User") 
NotSpam(msg,type)  
end
redis:setex(bot_id.."FDFGERB:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_, tonumber(redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 3), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam") then
Num_Msg_Max = redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam") 
end
if redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") then
Time_Spam = redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") 
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if redis:get(bot_id.."FDFGERB:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,"• عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا") 
redis:del(bot_id.."FDFGERB:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
return false 
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,"• ليس لدي صلاحية تغيير معلومات المجموعه يرجى المحاوله لاحقا") 
redis:del(bot_id.."FDFGERB:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,"• تم تغيير صورة المجموعه") 
end
end, nil) 
redis:del(bot_id.."FDFGERB:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_) 
end   
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
print(text)
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."FDFGERB:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."FDFGERB:ChekBotAdd") 
send(msg.chat_id_, msg.id_,"• تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
redis:set(bot_id..'FDFGERB:Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
redis:set(bot_id..'FDFGERB:Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
redis:set(bot_id..'FDFGERB:Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
redis:set(bot_id..'FDFGERB:Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
redis:del(bot_id.."FDFGERB:Broadcasting:Groups:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه خاص") 
redis:del(bot_id.."FDFGERB:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id..'FDFGERB:Num:User:Pv')  
send(msg.chat_id_, msg.id_,"• تمت الاذاعه الى *- "..#list.." * مشترك في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."FDFGERB:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه للمجموعات") 
redis:del(bot_id.."FDFGERB:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = redis:smembers(bot_id.."FDFGERB:ChekBotAdd") 
send(msg.chat_id_, msg.id_,"• تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ")     
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ""))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
redis:del(bot_id.."FDFGERB:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه بالتوجيه للمجموعات") 
redis:del(bot_id.."FDFGERB:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."FDFGERB:ChekBotAdd")   
send(msg.chat_id_, msg.id_,"• تم التوجيه الى *- "..#list.." * مجموعه في البوت ")     
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."FDFGERB:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء الاذاعه بالترجيه خاص") 
redis:del(bot_id.."FDFGERB:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = redis:smembers(bot_id.."FDFGERB:Num:User:Pv")   
send(msg.chat_id_, msg.id_,"• تم التوجيه الى *- "..#list.." * مجموعه في البوت ")     
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
redis:del(bot_id.."FDFGERB:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
return false
end
if redis:get(bot_id.."FDFGERB:Change:Name:Bot"..msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖" then   
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر تغير اسم البوت") 
redis:del(bot_id.."FDFGERB:Change:Name:Bot"..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."FDFGERB:Change:Name:Bot"..msg.sender_user_id_) 
redis:set(bot_id.."FDFGERB:Redis:Name:Bot",text) 
send(msg.chat_id_, msg.id_, "•  تم تغير اسم البوت الى - "..text)  
return false
end 
if redis:get(bot_id.."FDFGERB:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر تعين الايدي") 
redis:del(bot_id.."FDFGERB:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."FDFGERB:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_) 
redis:set(bot_id.."FDFGERB:Set:Id:Group"..msg.chat_id_,text:match("(.*)"))
send(msg.chat_id_, msg.id_,'• تم تعين الايدي الجديد')    
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."FDFGERB:Random:Sm"..msg.chat_id_) or "").."" and not redis:get(bot_id.."FDFGERB:Set:Sma"..msg.chat_id_) then
if not redis:get(bot_id.."FDFGERB:Set:Sma"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - سمايل او سمايلات")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."FDFGERB:Set:Sma"..msg.chat_id_,true)
return false
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."FDFGERB:Klam:Speed"..msg.chat_id_) or "").."" and not redis:get(bot_id.."FDFGERB:Speed:Tr"..msg.chat_id_) then
if not redis:get(bot_id.."FDFGERB:Speed:Tr"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - الاسرع او ترتيب")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."FDFGERB:Speed:Tr"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."FDFGERB:Klam:Hzor"..msg.chat_id_) or "").."" and not redis:get(bot_id.."FDFGERB:Set:Hzora"..msg.chat_id_) then
if not redis:get(bot_id.."FDFGERB:Set:Hzora"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - حزوره")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."FDFGERB:Set:Hzora"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."FDFGERB:Maany"..msg.chat_id_) or "").."" and not redis:get(bot_id.."FDFGERB:Set:Maany"..msg.chat_id_) then
if not redis:get(bot_id.."FDFGERB:Set:Maany"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - معاني")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."FDFGERB:Set:Maany"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."FDFGERB:Set:Aks:Game"..msg.chat_id_) or "").."" and not redis:get(bot_id.."FDFGERB:Set:Aks"..msg.chat_id_) then
if not redis:get(bot_id.."FDFGERB:Set:Aks"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - العكس")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."FDFGERB:Set:Aks"..msg.chat_id_,true)
end 
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"• عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false 
end 
local GETNUM = redis:get(bot_id.."FDFGERB:GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."FDFGERB:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."FDFGERB:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,"• مبروك فزت ويانه وخمنت الرقم الصحيح\n• تم اضافة { 5 } من النقاط \n")
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:incrby(bot_id.."FDFGERB:SADD:NUM"..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(redis:get(bot_id.."FDFGERB:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)) >= 3 then
redis:del(bot_id.."FDFGERB:SADD:NUM"..msg.chat_id_..msg.sender_user_id_)
redis:del(bot_id.."FDFGERB:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"• اوبس لقد خسرت في اللعبه \n• حظآ اوفر في المره القادمه \n• كان الرقم الذي تم تخمينه { "..GETNUM.." }")
else
send(msg.chat_id_, msg.id_,"• اوبس تخمينك غلط \n• ارسل رقم تخمنه مره اخرى ")
end
end
end
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"• عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false 
end 
local GETNUM = redis:get(bot_id.."FDFGERB:Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
redis:del(bot_id.."FDFGERB:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"• مبروك فزت وطلعت المحيبس بل ايد رقم { "..NUM.." }\n• لقد حصلت على { 3 }من نقاط يمكنك استبدالهن برسائل ")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
redis:del(bot_id.."FDFGERB:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,"• للاسف لقد خسرت \n• المحيبس بل ايد رقم { "..GETNUM.." }\n• حاول مره اخرى للعثور على المحيبس")
end
end
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."FDFGERB::Set:Moktlf"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."FDFGERB:Set:Moktlf:Bot"..msg.chat_id_) then 
redis:del(bot_id.."FDFGERB::Set:Moktlf"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - المختلف")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."FDFGERB:Set:Moktlf:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if text == ""..(redis:get(bot_id.."FDFGERB:Set:Amth"..msg.chat_id_) or "").."" then 
if not redis:get(bot_id.."FDFGERB:Set:Amth:Bot"..msg.chat_id_) then 
redis:del(bot_id.."FDFGERB:Set:Amth"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"\n• لقد فزت في اللعبه \n• اللعب مره اخره وارسل - امثله")
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_, 1)  
end
redis:set(bot_id.."FDFGERB:Set:Amth:Bot"..msg.chat_id_,true)
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."FDFGERB:id:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر اضافة رسائل") 
redis:del(bot_id.."FDFGERB:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."FDFGERB:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."FDFGERB:id:user"..msg.chat_id_)  
redis:del(bot_id.."FDFGERB:Msg_User"..msg.chat_id_..":"..msg.sender_user_id_) 
redis:incrby(bot_id.."FDFGERB:Num:Message:User"..msg.chat_id_..":"..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n• تم اضافة له - "..numadded.." رسائل")  
end
------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
redis:del(bot_id.."FDFGERB:idgem:user"..msg.chat_id_)  
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر اضافة جواهر") 
redis:del(bot_id.."FDFGERB:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."FDFGERB:games:add" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = redis:get(bot_id.."FDFGERB:idgem:user"..msg.chat_id_)  
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_,msg.id_,"\n• تم اضافة له - "..numadded.." مجوهرات")  
end
if text and redis:get(bot_id..'FDFGERB:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' or text == 'الغاء ✖' then 
redis:del(bot_id..'FDFGERB:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'• تم الغاء حفظ كليشة المطور')
return false
end
redis:set(bot_id..'FDFGERB:Texting:DevSlbotss',text)
redis:del(bot_id..'FDFGERB:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'• تم حفظ كليشة المطور')
send(msg.chat_id_,msg.id_,text)
return false
end
if text and redis:get(bot_id..'FDFGERB:Set:Cmd:Start:Bots') then
if text == 'الغاء' or text == 'الغاء ✖' then    
send(msg.chat_id_, msg.id_,"• تم الغاء حفظ كليشه امر /start") 
redis:del(bot_id..'FDFGERB:Set:Cmd:Start:Bots') 
return false
end
redis:set(bot_id.."FDFGERB:Set:Cmd:Start:Bot",text)  
send(msg.chat_id_, msg.id_,'• تم حفظ كليشه امر /start في البوت') 
redis:del(bot_id..'FDFGERB:Set:Cmd:Start:Bots') 
return false
end
------------------------------------------------------------------------------------------------------
if text and not Vips(msg) then  
local Text_Filter = redis:get(bot_id.."FDFGERB:Filter:Reply2"..text..msg.chat_id_)   
if Text_Filter then    
Send_Options(msg,msg.sender_user_id_,"reply","• "..Text_Filter)  
Delete_Message(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
if msg.content_.ID == 'MessageSticker' and not Owner(msg) then 
local filter = redis:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "•عذرا يا ⇠ [@"..data.username_.."]\n•  الملصق الذي ارسلته تم منعه من المجموعه \n" ) 
else
send(msg.chat_id_,0, "•عذرا يا ⇠ ["..data.first_name_.."](T.ME/hlIl3)\n• الملصق الذي ارسلته تم منعه من المجموعه \n" ) 
end
end,nil)   
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Owner(msg) then 
local filter = redis:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"•عذرا يا ⇠ [@"..data.username_.."]\n• الصوره التي ارسلتها تم منعها من المجموعه \n" ) 
else
send(msg.chat_id_,0,"•عذرا يا ⇠ ["..data.first_name_.."](T.ME/hlIl3)\n• الصوره التي ارسلتها تم منعها من المجموعه \n") 
end
end,nil)   
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Owner(msg) then 
local filter = redis:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"•عذرا يا ⇠ [@"..data.username_.."]\n• المتحركه التي ارسلتها تم منعها من المجموعه \n") 
else
send(msg.chat_id_,0,"•عذرا يا ⇠ ["..data.first_name_.."](T.ME/hlIl3)\n• المتحركه التي ارسلتها تم منعها من المجموعه \n" ) 
end
end,nil)   
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."FDFGERB:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
redis:set(bot_id.."FDFGERB:Command:Reids:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"• ارسل الامر الجديد ليتم وضعه مكان القديم")  
redis:del(bot_id.."FDFGERB:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_)
redis:set(bot_id.."FDFGERB:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
------------------------------------------------------------------------------------------------------------
if text and redis:get(bot_id.."FDFGERB:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = redis:get(bot_id.."FDFGERB:Command:Reids:Group:New"..msg.chat_id_)
redis:set(bot_id.."FDFGERB:Get:Reides:Commands:Group"..msg.chat_id_..":"..text,NewCmd)
redis:sadd(bot_id.."FDFGERB:Command:List:Group"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"• تم حفظ الامر باسم ← { "..text..' }')  
redis:del(bot_id.."FDFGERB:Command:Reids:Group:End"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if redis:get(bot_id.."FDFGERB:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر اضافة صلاحيه") 
local CmdDel = redis:get(bot_id.."FDFGERB:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:del(bot_id.."FDFGERB:Add:Validity:Group:Rt"..CmdDel..msg.chat_id_)
redis:srem(bot_id.."FDFGERB:Validitys:Group"..msg.chat_id_,CmdDel)  
redis:del(bot_id.."FDFGERB:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == "مدير" then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من منشئ \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز  ، ادمن }") 
return false
end
end
if text == "ادمن" then
if not Owner(msg) then 
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من مدير \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو ، مميز }") 
return false
end
end
if text == "مميز" then
if not Admin(msg) then
send(msg.chat_id_, msg.id_,"\n• الاستخدام خطا رتبتك اقل من ادمن \n• تستطيع اضافة صلاحيات الاتيه فقط ← { عضو }") 
return false
end
end
if text == "مدير" or text == "ادمن" or text == "مميز" or text == "عضو" then
local textn = redis:get(bot_id.."FDFGERB:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_)  
redis:set(bot_id.."FDFGERB:Add:Validity:Group:Rt"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "\n• تم اضافة الصلاحيه باسم ← { "..textn..' }') 
redis:del(bot_id.."FDFGERB:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."FDFGERB:Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_.."")
if redis:get(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."FDFGERB:Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"• تم حفظ رد للمدير بنجاح \n• ارسل ( "..test.." ) لرئية الرد")
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n• ارسل لي الرد لاضافته\n• تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n• تستطيع ايضا اضافة :\n• `#username` » معرف المستخدم \n• `#msgs` » عدد الرسائل\n• `#name` » اسم المستخدم\n• `#id` » ايدي المستخدم\n• `#stast` » موقع المستخدم \n• `#edit` » عدد السحكات ')
redis:set(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
redis:set(bot_id.."FDFGERB:Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:sadd(bot_id.."FDFGERB:List:Manager"..msg.chat_id_.."", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_.."") == "true2" then
send(msg.chat_id_, msg.id_,"• تم حذف الرد من ردود المدير ")
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Text"..text..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Photo"..text..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Video"..text..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:File"..text..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Audio"..text..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."FDFGERB:List:Manager"..msg.chat_id_.."", text)
return false
end
end
------------------------------------------------------------------------------------------------------------
if text and not redis:get(bot_id.."FDFGERB:Reply:Manager"..msg.chat_id_) then
if not redis:sismember(bot_id..'FDFGERB:Spam_For_Bot'..msg.sender_user_id_,text) then
local anemi = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local Text = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Audio"..text..msg.chat_id_)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsg = redis:get(bot_id..'FDFGERB:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'FDFGERB:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_, Text)
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr)
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, document)   
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,photo_caption)
redis:sadd(bot_id.."FDFGERB:Spam_For_Bot"..msg.sender_user_id_,text) 
end  
end
end
------------------------------------------------------------------------------------------------------------
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = redis:get(bot_id.."FDFGERB:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if redis:get(bot_id.."FDFGERB:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
redis:del(bot_id.."FDFGERB:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
redis:set(bot_id.."FDFGERB:Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"• تم حفظ رد للمطور \n• ارسل ( "..test.." ) لرئية الرد")
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."FDFGERB:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n• ارسل لي الكلمه الان \n• تستطيع اضافة ← { ملف ، فديو ، نص ، ملصق ، بصمه ، متحركه }\n• تستطيع ايضا اضافة :\n• `#username` » معرف المستخدم \n• `#msgs` » عدد الرسائل\n• `#name` » اسم المستخدم\n• `#id` » ايدي المستخدم\n• `#stast` » موقع المستخدم \n• `#edit` » عدد السحكات ')
redis:set(bot_id.."FDFGERB:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
redis:set(bot_id.."FDFGERB:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
redis:sadd(bot_id.."FDFGERB:List:Rd:Sudo", text)
return false end
end
------------------------------------------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if redis:get(bot_id.."FDFGERB:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"• تم حذف الرد من ردود المطور")
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
redis:del(bot_id..'FDFGERB:'..v..text)
end
redis:del(bot_id.."FDFGERB:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
redis:srem(bot_id.."FDFGERB:List:Rd:Sudo", text)
return false
end
end
if redis:get(bot_id.."FDFGERB:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_, msg.id_, "• تم الغاء حفظ القوانين") 
redis:del(bot_id.."FDFGERB:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
redis:set(bot_id.."FDFGERB::Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"• تم حفظ قوانين المجموعه") 
redis:del(bot_id.."FDFGERB:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  
if redis:get(bot_id.."FDFGERB:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر تغير وصف المجموعه") 
redis:del(bot_id.."FDFGERB:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
redis:del(bot_id.."FDFGERB:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request("https://api.telegram.org/bot"..token.."/setChatDescription?chat_id="..msg.chat_id_.."&description="..text) 
send(msg.chat_id_, msg.id_,"• تم تغيير وصف المجموعه")   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == "الغاء" then 
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر حفظ الترحيب") 
redis:del(bot_id.."FDFGERB:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
redis:del(bot_id.."FDFGERB:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
redis:set(bot_id.."FDFGERB:Get:Welcome:Group"..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"• تم حفظ ترحيب المجموعه")   
return false   
end
--------------------------------------------------------------------------------------------------------------
if redis:get(bot_id.."FDFGERB:link:set"..msg.chat_id_..""..msg.sender_user_id_) then
if text == "الغاء" then
send(msg.chat_id_,msg.id_, "\n• تم الغاء امر حفظ الرابط") 
redis:del(bot_id.."FDFGERB:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
redis:set(bot_id.."FDFGERB:link:set:Group"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"• تم حفظ الرابط بنجاح")       
redis:del(bot_id.."FDFGERB:link:set"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
if text then 
local DelFilter = redis:get(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if DelFilter and DelFilter == "DelFilter" then   
send(msg.chat_id_, msg.id_,"• تم الغاء منعها ")  
redis:del(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
redis:del(bot_id.."FDFGERB:Filter:Reply2"..text..msg.chat_id_)  
redis:srem(bot_id.."FDFGERB:List:Filter"..msg.chat_id_,text)  
return false 
end  
end
------------------------------------------------------------------------------------------------------------
if text then   
local SetFilter = redis:get(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if SetFilter and SetFilter == "SetFilter" then   
send(msg.chat_id_, msg.id_,"• ارسل التحذير عند ارسال الكلمه")  
redis:set(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"WirngFilter")  
redis:set(bot_id.."FDFGERB:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_, text)  
redis:sadd(bot_id.."FDFGERB:List:Filter"..msg.chat_id_,text)  
return false  
end  
end
------------------------------------------------------------------------------------------------------------
if text then  
local WirngFilter = redis:get(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
if WirngFilter and WirngFilter == "WirngFilter" then  
send(msg.chat_id_, msg.id_,"• تم منع الكلمه مع التحذير")  
redis:del(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
local test = redis:get(bot_id.."FDFGERB:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_)  
if text then   
redis:set(bot_id.."FDFGERB:Filter:Reply2"..test..msg.chat_id_, text)  
end  
redis:del(bot_id.."FDFGERB:Filter:Reply:Status"..msg.sender_user_id_..msg.chat_id_)  
return false 
end  
end
if redis:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "• تم الغاء الامر ") 
redis:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
redis:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '• المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '• عذا لا يمكنك وضع معرف حسابات في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'• عذا لا يمكنك وضع معرف مجوعه في الاشتراك ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'• البوت ادمن في القناة \n تم تفعيل الاشتراك الاجباري في \n ايدي القناة ('..data.id_..')\n• معرف القناة ([@'..data.type_.channel_.username_..'])') 
redis:set(bot_id..'add:ch:id',data.id_)
redis:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'• البوت ليس ادمن في القناة يرجى ترقيته ادمن ثم اعادة المحاوله ') 
end
return false  
end
end,nil)
end
if redis:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "• تم الغاء الامر ") 
redis:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
redis:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
redis:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,' تم تغيير رسالة الاشتراك بنجاح ')
end
---------------------------------------------------
if TypeForChat == ("ForUser") then
if text == '/start' then  
if Dev_Bots(msg) then
local Text_keyboard = '• اهلا بك في اوامر الكيبورد الجاهزه'
local List_keyboard = {
{'تفعيل تواصل البوت','تعطيل تواصل البوت'},
{'اذاعه خاص','اذاعه للمجموعات'},
{'اذاعه خاص بالتوجيه','اذاعه بالتوجيه'},
{'المطورين1','المكتومين عام','قائمه العام'},
{'المطورين','مسح المطورين1'},
{'مسح المكتومين عام','مسح المطورين','مسح قائمه العام'},
{'اضف سوال كت تويت','حذف سوال كت تويت'},
{'حذف سوال مقالات','اضف سوال مقالات'},
{'حذف الايدي عام','تعيين الايدي عام'},
{'احصائيات البوت'},
{'تعطيل الاشتراك','تفعيل الاشتراك '},
{'تغير الاشتراك ','الاشتراك الاجباري'},
{'تفعيل مغادرة البوت','تعطيل مغادرة البوت'},
{'تفعيل اذاعه المطورين','تعطيل اذاعه المطورين'},
{'تفعيل الوضع الخدمي','تعطيل الوضع الخدمي'},
{'تنظيف المجموعات','تنظيف المشتركين'},
{'ازالة كليشه ستارت','تغير كليشه ستارت'},
{'تغير اسم البوت'},
{'تغير كليشة المطور','ازالة كليشة المطور'},
{'تحديث الملفات','تحديث السورس'},
{'جلب نسخة خزن الكروبات'},
{'الغاء'}
}
send_inline_keyboard(msg.chat_id_,Text_keyboard,List_keyboard)
else
if not redis:get(bot_id..'FDFGERB:Ban:Cmd:Start'..msg.sender_user_id_) then
local GetCmdStart = redis:get(bot_id.."FDFGERB:Set:Cmd:Start:Bot")  
if not GetCmdStart then 
CmdStart = '\n• أهلآ بك في بوت '..(redis:get(bot_id.."FDFGERB:Redis:Name:Bot") or "ستورم")..''..
'\n• اختصاص البوت حماية المجموعات'..
'\n• لتفعيل البوت عليك اتباع مايلي ...'..
'\n• اضف البوت الى مجموعتك'..
'\n• ارفعه ادمن {مشرف}'..
'\n• ارسل كلمة { تفعيل } ليتم تفعيل المجموعه'..
'\n• سيتم ترقيتك منشئ اساسي في البوت'..
'\n• مطور البوت ← {['..UserName_Dev..']}'
send(msg.chat_id_, msg.id_,CmdStart) 
else
send(msg.chat_id_, msg.id_,GetCmdStart) 
end 
end
end
redis:setex(bot_id..'FDFGERB:Ban:Cmd:Start'..msg.sender_user_id_,60,true)
return false
end
if not Dev_Bots(msg) and not redis:sismember(bot_id..'FDFGERB:User:Ban:Pv',msg.sender_user_id_) and not redis:get(bot_id..'FDFGERB:Lock:Twasl') then
send(msg.sender_user_id_,msg.id_,'• تم ارسال رسالتك الى المطور ← { [@'..UserName_Dev..'] }')    
local List_id = {Id_Dev,msg.sender_user_id_}
for k,v in pairs(List_id) do   
tdcli_function({ID="GetChat",chat_id_=v},function(arg,chat) end,nil)
end
tdcli_function({ID="ForwardMessages",chat_id_=Id_Dev,from_chat_id_= msg.sender_user_id_,message_ids_={[0]=msg.id_},disable_notification_=1,from_background_=1},function(arg,data) 
if data and data.messages_ and data.messages_[0] ~= false and data.ID ~= "Error" then
if data and data.messages_ and data.messages_[0].content_.sticker_ then
Send_Optionspv(Id_Dev,0,msg.sender_user_id_,"reply_Pv","• قام بارسال الملصق")  
return false
end
end
end,nil)
end
if Dev_Bots(msg) then 
if msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
UserForward = result.forward_info_.sender_user_id_    
end     
if text == 'حظر' then
redis:sadd(bot_id..'FDFGERB:User:Ban:Pv',UserForward)  
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• تم حظره من تواصل البوت")  
return false  
end
if text =='الغاء الحظر' then
redis:srem(bot_id..'FDFGERB:User:Ban:Pv',UserForward) 
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• تم الغاء حظره من تواصل البوت")   
return false  
end 
tdcli_function({ID='GetChat',chat_id_=UserForward},function(a,s) end,nil)
tdcli_function({ID="SendChatAction",chat_id_=UserForward,action_={ID="SendMessageTypingAction",progress_=100}},function(arg,Get_Status) 
if (Get_Status.code_) == (400) or (Get_Status.code_) == (5) then
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• قام بحظر البوت لا تستطيع ارسال له رسائل")  
return false  
end 
if text then    
send(UserForward,msg.id_,text)    
elseif msg.content_.ID == 'MessageSticker' then    
sendSticker(UserForward, msg.id_, msg.content_.sticker_.sticker_.persistent_id_)   
elseif msg.content_.ID == 'MessagePhoto' then    
sendPhoto(UserForward, msg.id_,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
elseif msg.content_.ID == 'MessageAnimation' then    
sendDocument(UserForward, msg.id_, msg.content_.animation_.animation_.persistent_id_)    
elseif msg.content_.ID == 'MessageVoice' then    
sendVoice(UserForward, msg.id_, msg.content_.voice_.voice_.persistent_id_)    
end     
Send_Optionspv(Id_Dev,msg.id_,UserForward,"reply_Pv","• تم ارسال رسالتك اليه بنجاح")  
end,nil)end,nil)
end
if text == 'تعيين الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
send(msg.chat_id_, msg.id_,[[
܁يمكنك اضافة ܊
▹ `#username` - ܁ اسم المستخدم
▹ `#msgs` - ܁ عدد رسائل المستخدم
▹ `#photos` - ܁ عدد صور المستخدم
▹ `#id` - ܁ ايدي المستخدم
▹ `#stast` - ܁ رتبة المستخدم
▹ `#edit` - ܁ عدد تعديلات 
▹ `#game` - ܁ نقاط
]])
return false  
end
if redis:get(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"܁تم الغاء تعيين الايدي") 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
redis:set(bot_id.."KLISH:ID:bot",CHENGER_ID)
send(msg.chat_id_, msg.id_,'܁تم تعيين الايدي بنجاح')    
end
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id.."KLISH:ID:bot")
send(msg.chat_id_, msg.id_, '܁ تم ازالة كليشة الايدي ')
return false  
end 
if text and text:match("^تغير الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text and text:match("^تغير رساله الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي النص الذي تريده') 
return false  
end
if text == "حذف رساله الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "• تم مسح رساله الاشتراك ") 
return false  
end
if text and text:match("^وضع قناة الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text == "تفعيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
if redis:get(bot_id..'add:ch:id') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"• الاشتراك الاجباري مفعل \n على القناة ⇠ ["..addchusername.."]")
else
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," لا يوجد قناة للاشتراك الاجباري")
end
return false  
end
if text == "تعطيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id..'add:ch:id')
redis:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "الاشتراك الاجباري" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
if redis:get(bot_id..'add:ch:username') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تفعيل الاشتراك الاجباري \n على القناة ⇠ ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "• لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end
if text == "اضف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:set(bot_id.."FDFGERB:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id.."FDFGERB:gamebot:List:Manager")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."FDFGERB:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."FDFGERB:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."FDFGERB:gamebot:List:Manager", text)
return false end
end
if text == "اضف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id.."makal:bots")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."makal:bots", text)
return false end
end
if text == 'تغير كليشه ستارت' then
redis:set(bot_id..'FDFGERB:Set:Cmd:Start:Bots',true) 
send(msg.chat_id_, msg.id_,'• ارسل الان الكليشه ليتم وضعها') 
end
if text == 'ازالة كليشه ستارت' then
redis:del(bot_id..'FDFGERB:Set:Cmd:Start:Bot') 
send(msg.chat_id_, msg.id_,'• تم حذف كليشه ستارت') 
end
if text == "تفعيل مغادرة البوت" then   
redis:del(bot_id.."FDFGERB:Lock:Left"..msg.chat_id_)  
send(msg.chat_id_, msg.id_,"• تم تفعيل مغادرة البوت") 
end
if text == "تعطيل مغادرة البوت" then  
redis:set(bot_id.."FDFGERB:Lock:Left"..msg.chat_id_,true)   
send(msg.chat_id_, msg.id_, "• تم تعطيل مغادرة البوت") 
end
if text == "تفعيل اذاعه المطورين" then  
redis:del(bot_id.."FDFGERB:Broadcasting:Bot") 
send(msg.chat_id_, msg.id_,"• تم تفعيل الاذاعه \n• الان يمكن للمطورين الاذاعه" ) 
end
if text == "تعطيل اذاعه المطورين" then  
redis:set(bot_id.."FDFGERB:Broadcasting:Bot",true) 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه") 
end
if text == 'تفعيل الوضع الخدمي' then  
redis:del(bot_id..'FDFGERB:Free:Bot') 
send(msg.chat_id_, msg.id_,'• تم تفعيل البوت الخدمي \n• الان يمكن الجميع تفعيله') 
end
if text == 'تعطيل الوضع الخدمي' then  
redis:set(bot_id..'FDFGERB:Free:Bot',true) 
send(msg.chat_id_, msg.id_,'• تم تعطيل البوت الخدمي') 
end
if text == 'تغير كليشة المطور' then
redis:set(bot_id..'FDFGERB:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'•  ارسل لي الكليشه الان')
end
if text=="اذاعه خاص" then 
redis:setex(bot_id.."FDFGERB:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه للمجموعات" then 
redis:setex(bot_id.."FDFGERB:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه بالتوجيه" and DeveloperBot(msg) then 
redis:setex(bot_id.."FDFGERB:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم نشره في المجموعات") 
return false
end
if text=="اذاعه خاص بالتوجيه" and DeveloperBot(msg) then 
redis:setex(bot_id.."FDFGERB:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم نشره الى المشتركين") 
return false
end
if text == 'ازالة كليشة المطور' then
redis:del(bot_id..'FDFGERB:Texting:DevSlbotss')
send(msg.chat_id_, msg.id_,'•  تم حذف كليشه المطور')
end
if text == "تغير اسم البوت" then 
redis:setex(bot_id.."FDFGERB:Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"•  ارسل لي الاسم الان ")  
return false
end
if text == ("مسح قائمه العام") then
redis:del(bot_id.."FDFGERB:Removal:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين عام من البوت")
end
if text == ("مسح المكتومين عام") then
redis:del(bot_id.."FDFGERB:Silence:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين عام من البوت")
end
if text == ("مسح قائمه المطورين") then
redis:del(bot_id.."FDFGERB:Developer:Bot")
send(msg.chat_id_, msg.id_, "•  تم مسح المطورين من البوت  ")
end
if text == ("مسح قائمه المطورين1") then
redis:del(bot_id.."FDFGERB:Developer:Bot")
send(msg.chat_id_, msg.id_, "•  تم مسح المطورين من البوت  ")
end
if text == ("قائمه العام") then
local list = redis:smembers(bot_id.."FDFGERB:Removal:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد محظورين عام")
end
Gban = "\n• قائمة المحظورين عام في البوت\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == ("المكتومين عام") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Silence:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد مكتومين عام")
end
Gban = "\n• قائمة المكتومين عام في البوت\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == ("المطورين") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Developer:Bot")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطورين")
end
Sudos = "\n• قائمة مطورين في البوت \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text == ("المطورين1") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Developer:Bot1")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطورين")
end
Sudos = "\n• قائمة مطورين في البوت \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text =='احصائيات البوت' then 
send(msg.chat_id_, msg.id_,'*• عدد احصائيات البوت الكامله \n━━━━━━━━━━━━━\n• عدد المجموعات : '..(redis:scard(bot_id..'FDFGERB:ChekBotAdd') or 0)..'\n• عدد المشتركين : '..(redis:scard(bot_id..'FDFGERB:Num:User:Pv') or 0)..'*')
end
if text == 'حذف كليشه المطور' then
redis:del(bot_id..'FDFGERB:Texting:DevSlbotss')
send(msg.chat_id_, msg.id_,'•  تم حذف كليشه المطور')
end
if text == "تنظيف المشتركين" then
local pv = redis:smembers(bot_id..'FDFGERB:Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'FDFGERB:Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'• لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*• عدد المشتركين الان ←{ '..#pv..' }\n• تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n• اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف المجموعات" then
local group = redis:smembers(bot_id..'FDFGERB:ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'• لا توجد مجموعات وهميه ')   
else
local taha = (w + q)
local sendok = #group - taha
if q == 0 then
taha = ''
else
taha = '\n•  تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
groupss = ''
else
groupss = '\n•  تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*•  عدد المجموعات الان ← { '..#group..' } مجموعه '..groupss..''..taha..'\n• اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
return false
end
if text == 'جلب نسخة خزن الكروبات' then
GetFile_Bot(msg)
end
if text == 'تفعيل تواصل البوت' then  
redis:del(bot_id..'FDFGERB:Lock:Twasl') 
send(msg.chat_id_, msg.id_,'•  تم تفعيل التواصل ') 
end
if text == 'تعطيل تواصل البوت' then  
redis:set(bot_id..'FDFGERB:Lock:Twasl',true) 
send(msg.chat_id_, msg.id_,'•  تم تعطيل التواصل ') 
end
end 
end

---------------------------------------------------
if TypeForChat == ("ForSuppur") then
if text == "تحديث" then
dofile("FDFGERB.lua")  
send(msg.chat_id_, msg.id_, "🔂┇تم تحديث ملفات البوت")
end
if text and text:match("رفع (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local Tahaj = text:match("رفع (.*)")
tdcli_function({ID="GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(extra,result)
local statusrt = redis:get(bot_id.."FDFGERB:Add:Validity:Group:Rt"..Tahaj..msg.chat_id_)
if (Tahaj == 'مطور') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:sadd(bot_id.."FDFGERB:Developer:Bot",result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته مطور في البوت")  
elseif (Tahaj == 'مطور1') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:sadd(bot_id.."FDFGERB:Developer:Bot1",result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته مطور في البوت")  
elseif (Tahaj == 'منشئ اساسي') then
if not DeveloperBot(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:sadd(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته منشئ اساسي")  
elseif (Tahaj == 'منشئ') then
if not PresidentGroup(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
redis:sadd(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته منشئ المجموعه")  
elseif (Tahaj == 'مدير') then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:sadd(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته مدير المجموعه")
elseif (Tahaj == 'ادمن') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:sadd(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته ادمن في المجموعه")  
elseif (Tahaj == 'مميز') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته عضو مميز في")  
elseif (Tahaj == 'عظو مميز') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته عضو مميز في")  
elseif (Tahaj == 'عضو مميز') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم ترقيته عضو مميز في")  
elseif statusrt == "مميز" then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)")) 
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..Tahaj)  
elseif statusrt == "ادمن" then 
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:set(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))
redis:sadd(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..Tahaj)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:set(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,text:match("رفع (.*)"))  
redis:sadd(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..Tahaj)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.sender_user_id_,"reply","• تم رفعه "..Tahaj)  
end
end,nil)
end
if text and text:match("تنزيل (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local Tahaj = text:match("تنزيل (.*)")
local statusrt = redis:get(bot_id.."FDFGERB:Add:Validity:Group:Rt"..Tahaj..msg.chat_id_)
tdcli_function({ID="GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(extra,result)
if (Tahaj == 'مطور') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Developer:Bot",result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من المطورين")  
elseif (Tahaj == 'مطور1') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Developer:Bot1",result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله مطور من البوت")  
elseif (Tahaj == 'منشئ اساسي') then
if not DeveloperBot(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من المنشئين الاساسيين")  
elseif (Tahaj == 'منشئ') then
if not PresidentGroup(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من المنشئين")  
elseif (Tahaj == 'مدير') then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:srem(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من المدراء")
elseif (Tahaj == 'ادمن') then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:srem(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من الادمنيه")  
elseif (Tahaj == 'مميز') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من المميزين")  
elseif (Tahaj == 'عظو مميز') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من المميزين")  
elseif (Tahaj == 'عضو مميز') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله من المميزين")  
elseif statusrt == "مميز" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,Tahaj) 
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..Tahaj)  
elseif statusrt == "ادمن" then 
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:del(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,Tahaj)
redis:srem(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..Tahaj)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:del(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.sender_user_id_,Tahaj)
redis:srem(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.sender_user_id_)  
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..Tahaj)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.sender_user_id_,"reply","• تم تنزيله "..Tahaj)   
end
end,nil)
end
if text and text:match("^رفع (.*) @(.*)") then 
local Text = {string.match(text, "^(رفع) (.*) @(.*)$")}
local Tahaj = Text[2]
local statusrt = redis:get(bot_id.."FDFGERB:Add:Validity:Group:Rt"..Tahaj..msg.chat_id_)
tdcli_function({ID="SearchPublicChat",username_=Text[3]},function(extra,result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return send(msg.chat_id_,msg.id_,"*• عذرا هاذا معرف قناة*")    
end
if (Tahaj == 'مطور') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:sadd(bot_id.."FDFGERB:Developer:Bot",result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته مطور في البوت")  
elseif (Tahaj == 'مطور1') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:sadd(bot_id.."FDFGERB:Developer:Bot1",result.sender_user_id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته مطور في البوت")  
elseif (Tahaj == 'منشئ اساسي') then
if not DeveloperBot(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:sadd(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته منشئ اساسي")  
elseif (Tahaj == 'منشئ') then
if not PresidentGroup(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
redis:sadd(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته منشئ المجموعه")  
elseif (Tahaj == 'مدير') then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:sadd(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته مدير المجموعه")
elseif (Tahaj == 'ادمن') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:sadd(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته ادمن في المجموعه")  
elseif (Tahaj == 'مميز') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته عضو مميز في")  
elseif (Tahaj == 'عظو مميز') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته عضو مميز في")  
elseif (Tahaj == 'عضو مميز') then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم ترقيته عضو مميز في")  
elseif statusrt == "مميز" then
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.id_,Tahaj)
redis:sadd(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم رفعه "..Tahaj)  
elseif statusrt == "ادمن" then 
if not redis:get(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:set(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.id_,Tahaj)
redis:sadd(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم رفعه "..Tahaj)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:set(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.id_,Tahaj)
redis:sadd(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم رفعه "..Tahaj)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.id_,"reply","• تم رفعه "..Tahaj)  
end
else
send(msg.chat_id_, msg.id_,"*• المعرف غلط لا يمكن استخراج معلوماته*")
end
end,nil)
end
if text and text:match("^تنزيل (.*) @(.*)") then 
local Text = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
local Tahaj = Text[2]
local statusrt = redis:get(bot_id.."FDFGERB:Add:Validity:Group:Rt"..Tahaj..msg.chat_id_)
tdcli_function({ID="SearchPublicChat",username_=Text[3]},function(extra,result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return send(msg.chat_id_,msg.id_,"*• عذرا هاذا معرف قناة*")    
end
if (Tahaj == 'مطور') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Developer:Bot",result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من المطورين")  
elseif (Tahaj == 'مطور1') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Developer:Bot1",result.sender_user_id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله مطور من البوت")  
elseif (Tahaj == 'منشئ اساسي') then
if not DeveloperBot(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من المنشئين الاساسيين")  
elseif (Tahaj == 'منشئ') then
if not PresidentGroup(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من المنشئين")  
elseif (Tahaj == 'مدير') then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:srem(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من المدراء ")
elseif (Tahaj == 'ادمن') then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:srem(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من الادمنيه")  
elseif (Tahaj == 'مميز') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من المميزين")  
elseif (Tahaj == 'عظو مميز') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من المميزين")  
elseif (Tahaj == 'عضو مميز') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم تنزيله من المميزين")  
elseif statusrt == "مميز" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.id_,Tahaj)
redis:srem(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..Tahaj)  
elseif statusrt == "ادمن" then 
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
redis:del(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.id_,Tahaj)
redis:srem(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..Tahaj)  
elseif statusrt == "مدير" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:del(bot_id.."FDFGERB:Add:Validity:Users"..msg.chat_id_..result.id_,Tahaj)
redis:srem(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_,result.id_)  
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..Tahaj)  
elseif statusrt == "عضو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
return Send_Options(msg,result.id_,"reply","• تم تنزيله "..Tahaj)  
end
else
send(msg.chat_id_, msg.id_,"*• المعرف غلط لا يمكن استخراج معلوماته*")
end
end,nil)
end
if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Admin(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if (result.id_) then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا هاذا معرف قناة")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n• لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
else
Send_Options(msg,result.id_,"reply", "• تم تقيده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, FunctionStatus, nil)
end
if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Admin(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
function FunctionStatus(arg, result)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Rank_Checking(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n• لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
else
Send_Options(msg,result.sender_user_id_,"reply", "• تم تقيده لمدة ~ { "..TextEnd[2]..' '..TextEnd[3]..'}')
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunctionStatus, nil)
end

if text and text:match("حظر (.*)") or text and text:match("تقيد (.*)") or text and text:match("كتم (.*)") or text and text:match("طرد (.*)") or text and text:match("تقيد (.*)") or text and text:match("حظر عام (.*)") or text and text:match("كتم عام (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local Tahaj = text:match("حظر (.*)") or text:match("كتم (.*)") or text:match("تقيد (.*)") or text:match("طرد (.*)") or text:match("تقيد (.*)") or text:match("حظر عام (.*)") or text:match("كتم عام (.*)")
tdcli_function({ID="GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(extra,result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
if Rank_Checking(result.sender_user_id_, msg.chat_id_) == true then
return send(msg.chat_id_, msg.id_, "\n⚠┇لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.sender_user_id_,msg.chat_id_).."")
end
if (Tahaj == 'حظر عام') then
if not Dev_Bots(msg) then 
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:sadd(bot_id.."FDFGERB:Removal:User:Groups",result.sender_user_id_)
KickGroup(msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم حظره عام في البوت")  
elseif (Tahaj == 'كتم عام') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:sadd(bot_id.."FDFGERB:Silence:User:Groups"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم كتمه عام في البوت")  
elseif (Tahaj == 'حظر') then
if redis:get(bot_id..'FDFGERB:Lock:Ban:Group'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
KickGroup(msg.chat_id_,result.sender_user_id_)
redis:sadd(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم حظره من المجموعه")  
elseif (Tahaj == 'كتم') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم كتمه في المجموعه")
elseif (Tahaj == 'طرد') then
if redis:get(bot_id..'FDFGERB:Lock:Ban:Group'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
KickGroup(msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم طرده من المجموعه")  
elseif (Tahaj == 'تقيد') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم تقييده في المجموعه")  
end
end,nil)
end
if text and text:match("الغاء حظر (.*)") or text and text:match("الغاء تقيد (.*)") or text and text:match("الغاء كتم (.*)") or text and text:match("الغاء تقيد (.*)") or text and text:match("الغاء العام (.*)") or text and text:match("الغاء كتم عام (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local Tahaj = text:match("الغاء حظر (.*)") or text:match("الغاء تقيد (.*)") or text:match("الغاء كتم (.*)") or text:match("الغاء تقيد (.*)") or text:match("الغاء العام (.*)") or text:match("الغاء كتم عام (.*)")
tdcli_function({ID="GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(extra,result)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
if (Tahaj == 'الغاء العام') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Removal:User:Groups",result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم الغاء حظره عام في البوت")  
elseif (Tahaj == 'الغاء كتم عام') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:srem(bot_id.."FDFGERB:Silence:User:Groups"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم الغاء كتمه عام في البوت")  
elseif (Tahaj == 'الغاء حظر') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
redis:srem(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم الغاء حظره من المجموعه")  
elseif (Tahaj == 'الغاء كتم') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:srem(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
return Send_Options(msg,result.sender_user_id_,"reply","• تم الغاء كتمه في المجموعه")
elseif (Tahaj == 'الغاء تقيد') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
return Send_Options(msg,result.sender_user_id_,"reply","• تم الغاء تقييده في المجموعه")  
end
end,nil)
end

if text and text:match("حظر") or text and text:match("تقيد") or text and text:match("كتم") or text and text:match("طرد") or text and text:match("حظر عام") or text and text:match("كتم عام") then 
local Tahajj = {string.match(text, "^(حظر) @(.*)$")} or {string.match(text, "^(تقيد) @(.*)$")} or {string.match(text, "^(كتم) @(.*)$")} or {string.match(text, "^(طرد) @(.*)$")} or {string.match(text, "^(حظر عام) @(.*)$")} or {string.match(text, "^(كتم عام) @(.*)$")} 
local Tahaj = Tahajj[1]
tdcli_function({ID="SearchPublicChat",username_=Tahajj[2]},function(extra,result)
if (result.id_) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return send(msg.chat_id_,msg.id_,"*• عذرا هاذا معرف قناة*")    
end
if Rank_Checking(result.id_, msg.chat_id_) == true then
return send(msg.chat_id_, msg.id_, "\n⚠┇لا تستطيع -( حظر , طرد , كتم , تقيد ) : "..Get_Rank(result.id_,msg.chat_id_).."")
end
if (Tahaj == 'حظر عام') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
KickGroup(msg.chat_id_,result.id_)
redis:sadd(bot_id.."FDFGERB:Removal:User:Groups",result.id_)
return Send_Options(msg,result.id_,"reply","• تم حظره عام في البوت")  
elseif (Tahaj == 'كتم عام') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:sadd(bot_id.."FDFGERB:Silence:User:Groups"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم كتمه عام في البوت")  
elseif (Tahaj == 'حظر') then
if redis:get(bot_id..'FDFGERB:Lock:Ban:Group'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
KickGroup(msg.chat_id_,result.id_)
redis:sadd(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم حظره من المجموعه")  
elseif (Tahaj == 'كتم') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:sadd(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم كتمه في المجموعه")
elseif (Tahaj == 'طرد') then
if redis:get(bot_id..'FDFGERB:Lock:Ban:Group'..msg.chat_id_) and not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر معل *')
end
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end
KickGroup(msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم طرده من المجموعه")  
elseif (Tahaj == 'تقيد') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
return Send_Options(msg,result.id_,"reply","• تم تقييده في المجموعه")  
end
end
end,nil)
end
if text and text:match("الغاء حظر (.*)") or text and text:match("الغاء تقيد (.*)") or text and text:match("الغاء كتم (.*)") or text and text:match("الغاء العام (.*)") or text and text:match("الغاء كتم عام (.*)") then 
local Tahajj = {string.match(text, "^(الغاء حظر) @(.*)$")} or {string.match(text, "^(الغاء تقيد) @(.*)$")} or {string.match(text, "^(الغاء كتم) @(.*)$")} or {string.match(text, "^(الغاء العام) @(.*)$")} or {string.match(text, "^(الغاء كتم عام) @(.*)$")} 
local Tahaj = Tahajj[1]
tdcli_function({ID="SearchPublicChat",username_=Tahajj[2]},function(extra,result)
if (result.id_) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,"• عذرآ البوت ليس ادمن") 
return false  
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
return send(msg.chat_id_,msg.id_,"*• عذرا هاذا معرف قناة*")    
end
if (Tahaj == 'الغاء العام') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:srem(bot_id.."FDFGERB:Removal:User:Groups",result.id_)
return Send_Options(msg,result.id_,"reply","• تم الغاء حظره عام في البوت")  
elseif (Tahaj == 'الغاء كتم عام') then
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطورين فقط *')
end
redis:srem(bot_id.."FDFGERB:Silence:User:Groups"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم الغاء كتمه عام في البوت")  
elseif (Tahaj == 'الغاء حظر') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئ الاساسي فقط *')
end
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
redis:srem(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم الغاء حظره من المجموعه")  
elseif (Tahaj == 'الغاء كتم') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:srem(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.id_)
return Send_Options(msg,result.id_,"reply","• تم الغاء كتمه في المجموعه")
elseif (Tahaj == 'الغاء تقيد') then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
return Send_Options(msg,result.id_,"reply","• تم الغاء تقييده في المجموعه")  
end
end
end,nil)
end

if text == ("قائمه العام") and Dev_Bots(msg) or text == ("المحظورين عام") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Removal:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد محظورين عام")
end
Gban = "\n• قائمة المحظورين عام في البوت\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == ("المكتومين عام") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Silence:User:Groups")
if #list == 0 then
return send(msg.chat_id_, msg.id_,"• لا يوجد مكتومين عام")
end
Gban = "\n• قائمة المكتومين عام في البوت\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Gban = Gban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Gban)
end
end,nil)
end
end
if text == ("المطورين") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Developer:Bot")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطورين")
end
Sudos = "\n• قائمة مطورين في البوت \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text == ("المطورين1") and Dev_Bots(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Developer:Bot1")
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مطورين")
end
Sudos = "\n• قائمة مطورين في البوت \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Sudos = Sudos..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Sudos)
end
end,nil)
end
end
if text == "المنشئين الاساسين" and DeveloperBot(msg) or text == "الاساسين" and DeveloperBot(msg) then
local list = redis:smembers(bot_id.."FDFGERB:President:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد منشئين اساسيين")
end
Asase = "\n• قائمة المنشئين الاساسين في المجموعه\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Asase = Asase..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Asase)
end
end,nil)
end
end
if text == ("المنشئين") and PresidentGroup(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد منشئين")
end
Monsh = "\n• قائمة منشئين المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Monsh = Monsh..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Monsh)
end
end,nil)
end
end
if text == ("المدراء") and Constructor(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مدراء")
end
mder = "\n• قائمة مدراء المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
mder = mder..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, mder)
end
end,nil)
end
end
if text == ("الادمنيه") and Owner(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد ادمنيه")
end
Admin = "\n• قائمة الادمنيه في المجموعه\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Admin = Admin..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Admin)
end
end,nil)
end
end
if text == ("المميزين") and Admin(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مميزين")
end
vips = "\n• قائمة المميزين في المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
vips = vips..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, vips)
end
end,nil)
end
end
if text == ("المكتومين") and Admin(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد مكتومين")
end
selint = "\n• قائمة المكتومين في المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
selint = selint..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, selint)
end
end,nil)
end
end
if text == ("المحظورين") and Admin(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_)
if #list == 0 then
return send(msg.chat_id_, msg.id_, "• لا يوجد محظورين")
end
ban = "\n• قائمة المدراء في المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
ban = ban..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, ban)
end
end,nil)
end
end

if text == ("مسح قائمه العام") and Dev_Bots(msg) or text == ("مسح المحظورين عام") and Dev_Bots(msg) then
redis:del(bot_id.."FDFGERB:Removal:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين عام من البوت")
end
if text == ("مسح المكتومين عام") and Dev_Bots(msg) or text == ("مسح المحظورين عام") and Dev_Bots(msg) then
redis:del(bot_id.."FDFGERB:Silence:User:Groups")
send(msg.chat_id_, msg.id_, "• تم مسح المكتومين عام من البوت")
end
if text == ("مسح المطورين") and Dev_Bots(msg) then
redis:del(bot_id.."FDFGERB:Developer:Bot")
send(msg.chat_id_, msg.id_, "•  تم مسح المطورين من البوت  ")
end
if text == ("مسح المطورين1") and Dev_Bots(msg) then
redis:del(bot_id.."FDFGERB:Developer:Bot1")
send(msg.chat_id_, msg.id_, "•  تم مسح المطورين من البوت  ")
end
if text == ("مسح المنشئين الاساسين") and DeveloperBot(msg) or text == "مسح الاساسين" and DeveloperBot(msg)  then
redis:del(bot_id.."FDFGERB:President:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المنشئين الاساسيين في المجموعه")
end
if text == ("مسح المنشئين الاساسين") or text == "مسح الاساسين" then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
redis:del(bot_id.."FDFGERB:President:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المنشئين الاساسيين في المجموعه")
end
end,nil)
end
if text == ("مسح المنشئين") and PresidentGroup(msg) then
redis:del(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المنشئين في المجموعه")
end
if text == ("مسح المدراء") and Constructor(msg) then
redis:del(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المدراء في المجموعه")
end
if text == ("مسح الادمنيه") and Owner(msg) then
redis:del(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح الادمنيه في المجموعه")
end
if text == ("مسح المميزين") and Admin(msg) then
redis:del(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المميزين في المجموعه")
end
if text == ("مسح المكتومين") and Admin(msg) then
redis:del(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "•  تم مسح المكتومين في المجموعه")
end
if text == ("مسح المحظورين") and Admin(msg) then
redis:del(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "• تم مسح المحظورين في المجموعه")
end
if text and text:match("قفل (.*)") or text and text:match("فتح (.*)") and Admin(msg) then 
local Tahaj = text:match("قفل (.*)") or text:match("فتح (.*)")
local Tahaj = 'قفل '..Tahaj or 'فتح '..Tahaj 
if Tahaj == "قفل الدردشه" then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end 
redis:set(bot_id.."FDFGERB:Lock:text"..msg.chat_id_,true) 
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الدردشه")  
elseif Tahaj == "قفل الاضافه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:set(bot_id.."FDFGERB:Lock:AddMempar"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل اضافة الاعضاء")  
elseif Tahaj == "قفل الدخول" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:set(bot_id.."FDFGERB:Lock:Join"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل دخول الاعضاء")  
elseif Tahaj == "قفل البوتات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:set(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل البوتات")  
elseif Tahaj == "قفل البوتات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:set(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل البوتات")  
elseif Tahaj == "قفل الاشعارات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end  
redis:set(bot_id.."FDFGERB:Lock:tagservr"..msg.chat_id_,true)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الاشعارات")  
elseif Tahaj == "قفل التثبيت" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end 
redis:set(bot_id.."FDFGERB:lockpin"..msg.chat_id_, true) 
redis:sadd(bot_id.."FDFGERB:Lock:pin",msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  redis:set(bot_id.."FDFGERB:Get:Id:Msg:Pin"..msg.chat_id_,data.pinned_message_id_)  end,nil)
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل التثبيت هنا")  
elseif Tahaj == "قفل التعديل" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end 
redis:set(bot_id.."FDFGERB:Lock:edit"..msg.chat_id_,true) 
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل تعديل")  
elseif Tahaj == "قفل تعديل الميديا" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end 
redis:set(bot_id.."FDFGERB:Lock:edit"..msg.chat_id_,true) 
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل تعديل")  
elseif Tahaj == "قفل الكل" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end  
redis:set(bot_id.."FDFGERB:Lock:tagservrbot"..msg.chat_id_,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do;redis:set(bot_id..lock..msg.chat_id_,"del");end
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل جميع الاوامر")  
elseif Tahaj == "فتح الاضافه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:AddMempar"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح اضافة الاعضاء")  
elseif Tahaj == "قفل الفشار" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:set(bot_id.."lock:Fshar"..msg.chat_id_,true)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الفشار")  
elseif Tahaj == "قفل السمايلات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:set(bot_id.."lock:emoje"..msg.chat_id_,true)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل السمايلات")  
elseif Tahaj == "فتح الفشار" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:del(bot_id.."lock:Fshar"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم فتح الفشار")  
elseif Tahaj == "فتح السمايلات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:del(bot_id.."lock:emoje"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم فتح السمايلات")  
elseif Tahaj == "فتح الدردشه" then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:text"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الدردشه")  
elseif Tahaj == "فتح الدخول" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:Join"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح دخول الاعضاء")  
elseif Tahaj == "فتح البوتات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فـتح البوتات")  
elseif Tahaj == "فتح البوتات " then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","🍃\n• تم فـتح البوتات")  
elseif Tahaj == "فتح الاشعارات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end  
redis:del(bot_id.."FDFGERB:Lock:tagservr"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فـتح الاشعارات")  
elseif Tahaj == "فتح التثبيت" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end 
redis:del(bot_id.."FDFGERB:lockpin"..msg.chat_id_)  
redis:srem(bot_id.."FDFGERB:Lock:pin",msg.chat_id_)
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فـتح التثبيت هنا")  
elseif Tahaj == "فتح التعديل" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:edit"..msg.chat_id_) 
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فـتح تعديل")  
elseif Tahaj == "فتح التعديل الميديا" then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:edit"..msg.chat_id_) 
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فـتح تعديل")  
elseif Tahaj == "فتح الكل" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:del(bot_id.."FDFGERB:Lock:tagservrbot"..msg.chat_id_)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do;redis:del(bot_id..lock..msg.chat_id_);end
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فـتح جميع الاوامر")  
elseif Tahaj == "قفل الروابط" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الروابط")  
elseif Tahaj == "قفل الروابط بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الروابط")  
elseif Tahaj == "قفل الروابط بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الروابط")  
elseif Tahaj == "قفل الروابط بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الروابط")  
elseif Tahaj == "فتح الروابط" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الروابط")  
elseif Tahaj == "قفل المعرفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل المعرفات")  
elseif Tahaj == "قفل المعرفات بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل المعرفات")  
elseif Tahaj == "قفل المعرفات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل المعرفات")  
elseif Tahaj == "قفل المعرفات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل المعرفات")  
elseif Tahaj == "فتح المعرفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح المعرفات")  
elseif Tahaj == "قفل التاك" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل التاك")  
elseif Tahaj == "قفل التاك بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل التاك")  
elseif Tahaj == "قفل التاك بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل التاك")  
elseif Tahaj == "قفل التاك بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل التاك")  
elseif Tahaj == "فتح التاك" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح التاك")  
elseif Tahaj == "قفل الشارحه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الشارحه")  
elseif Tahaj == "قفل الشارحه بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الشارحه")  
elseif Tahaj == "قفل الشارحه بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الشارحه")  
elseif Tahaj == "قفل الشارحه بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الشارحه")  
elseif Tahaj == "فتح الشارحه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الشارحه")  
elseif Tahaj == "قفل الصور"then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الصور")  
elseif Tahaj == "قفل الصور بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الصور")  
elseif Tahaj == "قفل الصور بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الصور")  
elseif Tahaj == "قفل الصور بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الصور")  
elseif Tahaj == "فتح الصور" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الصور")  
elseif Tahaj == "قفل الفيديو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الفيديو")  
elseif Tahaj == "قفل الفيديو بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الفيديو")  
elseif Tahaj == "قفل الفيديو بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الفيديو")  
elseif Tahaj == "قفل الفيديو بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الفيديو")  
elseif Tahaj == "فتح الفيديو" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الفيديو")  
elseif Tahaj == "قفل المتحركه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل المتحركه")  
elseif Tahaj == "قفل المتحركه بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل المتحركه")  
elseif Tahaj == "قفل المتحركه بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل المتحركه")  
elseif Tahaj == "قفل المتحركه بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل المتحركه")  
elseif Tahaj == "فتح المتحركه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح المتحركه")  
elseif Tahaj == "قفل الالعاب" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الالعاب")  
elseif Tahaj == "قفل الالعاب بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الالعاب")  
elseif Tahaj == "قفل الالعاب بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الالعاب")  
elseif Tahaj == "قفل الالعاب بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الالعاب")  
elseif Tahaj == "فتح الالعاب" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الالعاب")  
elseif Tahaj == "قفل الاغاني" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الاغاني")  
elseif Tahaj == "قفل الاغاني بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الاغاني")  
elseif Tahaj == "قفل الاغاني بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الاغاني")  
elseif Tahaj == "قفل الاغاني بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الاغاني")  
elseif Tahaj == "فتح الاغاني" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Audio"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الاغاني")  
elseif Tahaj == "قفل الصوت" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الصوت")  
elseif Tahaj == "قفل الصوت بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الصوت")  
elseif Tahaj == "قفل الصوت بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الصوت")  
elseif Tahaj == "قفل الصوت بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الصوت")  
elseif Tahaj == "فتح الصوت" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الصوت")  
elseif Tahaj == "قفل الكيبورد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الكيبورد")  
elseif Tahaj == "قفل الكيبورد بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الكيبورد")  
elseif Tahaj == "قفل الكيبورد بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الكيبورد")  
elseif Tahaj == "قفل الكيبورد بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الكيبورد")  
elseif Tahaj == "فتح الكيبورد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الكيبورد")  
elseif Tahaj == "قفل الملصقات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الملصقات")  
elseif Tahaj == "قفل الملصقات بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الملصقات")  
elseif Tahaj == "قفل الملصقات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الملصقات")  
elseif Tahaj == "قفل الملصقات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الملصقات")  
elseif Tahaj == "فتح الملصقات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الملصقات")  
elseif Tahaj == "قفل التوجيه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل التوجيه")  
elseif Tahaj == "قفل التوجيه بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل التوجيه")  
elseif Tahaj == "قفل التوجيه بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل التوجيه")  
elseif Tahaj == "قفل التوجيه بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل التوجيه")  
elseif Tahaj == "فتح التوجيه" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح التوجيه")  
elseif Tahaj == "قفل الملفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الملفات")  
elseif Tahaj == "قفل الملفات بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الملفات")  
elseif Tahaj == "قفل الملفات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الملفات")  
elseif Tahaj == "قفل الملفات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الملفات")  
elseif Tahaj == "فتح الملفات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الملفات")  
elseif Tahaj == "قفل السيلفي" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل السيلفي")  
elseif Tahaj == "قفل السيلفي بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل السيلفي")  
elseif Tahaj == "قفل السيلفي بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل السيلفي")  
elseif Tahaj == "قفل السيلفي بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل السيلفي")  
elseif Tahaj == "فتح السيلفي" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح السيلفي")  
elseif Tahaj == "قفل الماركداون" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الماركداون")  
elseif Tahaj == "قفل الماركداون بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الماركداون")  
elseif Tahaj == "قفل الماركداون بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الماركداون")  
elseif Tahaj == "قفل الماركداون بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الماركداون")  
elseif Tahaj == "فتح الماركداون" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الماركداون")  
elseif Tahaj == "قفل الجهات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الجهات")  
elseif Tahaj == "قفل الجهات بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الجهات")  
elseif Tahaj == "قفل الجهات بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الجهات")  
elseif Tahaj == "قفل الجهات بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الجهات")  
elseif Tahaj == "فتح الجهات" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الجهات")  
elseif Tahaj == "قفل الكلايش" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الكلايش")  
elseif Tahaj == "قفل الكلايش بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الكلايش")  
elseif Tahaj == "قفل الكلايش بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الكلايش")  
elseif Tahaj == "قفل الكلايش بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الكلايش")  
elseif Tahaj == "فتح الكلايش" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الكلايش")  
elseif Tahaj == "قفل الانلاين" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_,"del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفـل الانلاين")  
elseif Tahaj == "قفل الانلاين بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_,"ked")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفـل الانلاين")  
elseif Tahaj == "قفل الانلاين بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_,"ktm")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفـل الانلاين")  
elseif Tahaj == "قفل الانلاين بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:set(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_,"kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفـل الانلاين")  
elseif Tahaj == "فتح الانلاين" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id.."FDFGERB:Lock:Inlen"..msg.chat_id_)  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح الانلاين")  
elseif Tahaj == "قفل التكرار بالطرد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:hset(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_ ,"Spam:User","kick")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kick","• تم قفل التكرار")
elseif Tahaj == "قفل التكرار" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:hset(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status","• تم قفل التكرار بالحذف")
elseif Tahaj == "قفل التكرار بالتقيد" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:hset(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Kid","• تم قفل التكرار")
elseif Tahaj == "قفل التكرار بالكتم" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:hset(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_ ,"Spam:User","mute")  
return Send_Options(msg,msg.sender_user_id_,"Close_Status_Ktm","• تم قفل التكرار")
elseif Tahaj == "فتح التكرار" then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end 
redis:hdel(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_ ,"Spam:User")  
return Send_Options(msg,msg.sender_user_id_,"Open_Status","• تم فتح التكرار")
end
end

if text == 'تفعيل جلب الرابط' or text == 'تفعيل الرابط' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end  
redis:set(bot_id..'FDFGERB:Link_Group'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل جلب الرابط المجموعه') 
end
if text == 'تعطيل جلب الرابط' or text == 'تعطيل الرابط' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end
redis:del(bot_id..'FDFGERB:Link_Group'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل جلب رابط المجموعه') 
end
if text == 'تفعيل الترحيب' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end  
redis:set(bot_id..'FDFGERB:Chek:Welcome'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل ترحيب المجموعه') 
end
if text == 'تعطيل الترحيب' then
if not Admin(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : الادمنيه فقط *')
end  
redis:del(bot_id..'FDFGERB:Chek:Welcome'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل ترحيب المجموعه') 
end
if text == 'تفعيل ردود المدير' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'FDFGERB:Reply:Manager'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل ردود المدير') 
end
if text == 'تعطيل ردود المدير' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end  
redis:set(bot_id..'FDFGERB:Reply:Manager'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل ردود المدير' ) 
end
if text == 'تفعيل ردود المطور' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'FDFGERB:Reply:Sudo'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل ردود المطور' ) 
end
if text == 'تعطيل ردود المطور' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end  
redis:set(bot_id..'FDFGERB:Reply:Sudo'..msg.chat_id_,true)   
return send(msg.chat_id_, msg.id_,'• تم تعطيل ردود المطور' ) 
end
if text == 'تفعيل ضافني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:set(bot_id..'Added:Me'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل امر ضافني') 
end
if text == 'تفعيل صيح' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:set(bot_id..'Seh:User'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل امر صيح') 
end
if text == 'تفعيل اطردني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'FDFGERB:Cheking:Kick:Me:Group'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل امر اطردني') 
end
if text == 'تعطيل ضافني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'Added:Me'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل امر ضافني') 
end
if text == 'تعطيل صيح' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'Seh:User'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل امر صيح') 
end
if text == 'تعطيل اطردني' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end  
redis:set(bot_id..'FDFGERB:Cheking:Kick:Me:Group'..msg.chat_id_,true)  
return send(msg.chat_id_, msg.id_,'• تم تعطيل امر اطردني') 
end
if text == 'تفعيل المغادره' then   
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:del(bot_id..'FDFGERB:Lock:Left'..msg.chat_id_)  
return send(msg.chat_id_, msg.id_,'• تم تفعيل مغادرة البوت') 
end
if text == 'تعطيل المغادره' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:set(bot_id..'FDFGERB:Lock:Left'..msg.chat_id_,true)   
return send(msg.chat_id_, msg.id_, '• تم تعطيل مغادرة البوت') 
end
if text == 'تفعيل الاذاعه' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:del(bot_id..'FDFGERB:Broadcasting:Bot') 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الاذاعه \n• الان يمكن للمطورين الاذاعه' ) 
end
if text == 'تعطيل الاذاعه' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:set(bot_id..'FDFGERB:Broadcasting:Bot',true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الاذاعه') 
end
if text == 'تفعيل الايدي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'FDFGERB:Lock:Id:Photo'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الايدي') 
end
if text == 'تعطيل الايدي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end  
redis:set(bot_id..'FDFGERB:Lock:Id:Photo'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الايدي') 
end
if text == 'تفعيل الايدي بالصوره' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'FDFGERB:Lock:Id:Py:Photo'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الايدي بالصوره') 
end
if text == 'تعطيل الايدي بالصوره' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end  
redis:set(bot_id..'FDFGERB:Lock:Id:Py:Photo'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الايدي بالصوره') 
end
if text == 'تعطيل الالعاب' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end   
redis:del(bot_id..'FDFGERB:Lock:Game:Group'..msg.chat_id_) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل الالعاب') 
end
if text == 'تفعيل الالعاب' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المدراء فقط *')
end  
redis:set(bot_id..'FDFGERB:Lock:Game:Group'..msg.chat_id_,true) 
return send(msg.chat_id_, msg.id_,'• تم تفعيل الالعاب') 
end
if text == 'تفعيل البوت الخدمي' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:del(bot_id..'FDFGERB:Free:Bot') 
return send(msg.chat_id_, msg.id_,'• تم تفعيل البوت الخدمي \n• الان يمكن الجميع تفعيله') 
end
if text == 'تعطيل البوت الخدمي' then  
if not Dev_Bots(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المطور الاساسي فقط *')
end
redis:set(bot_id..'FDFGERB:Free:Bot',true) 
return send(msg.chat_id_, msg.id_,'• تم تعطيل البوت الخدمي') 
end
if text == 'تعطيل الطرد' or text == 'تعطيل الحظر' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:set(bot_id..'FDFGERB:Lock:Ban:Group'..msg.chat_id_,'true')
return send(msg.chat_id_, msg.id_, '• تم تعطيل - ( الحظر - الطرد ) ')
end
if text == 'تفعيل الطرد' or text == 'تفعيل الحظر' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:del(bot_id..'FDFGERB:Lock:Ban:Group'..msg.chat_id_)
return send(msg.chat_id_, msg.id_, '• تم تفعيل - ( الحظر - الطرد ) ')
end
if text == 'تعطيل الرفع' or text == 'تعطيل الترقيه' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:set(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_,'true')
return send(msg.chat_id_, msg.id_, '• تم تعطيل رفع - ( الادمن - المميز ) ')
end
if text == 'تفعيل الرفع' or text == 'تفعيل الترقيه' then
if not Constructor(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:del(bot_id..'FDFGERB:Cheking:Seted'..msg.chat_id_)
return send(msg.chat_id_, msg.id_, '• تم تفعيل رفع - ( الادمن - المميز ) ')
end
if text == 'تعطيل صورتي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:set(bot_id..'my_photo:status:bot'..msg.chat_id_,'taha')
return send(msg.chat_id_, msg.id_, '• تم تعطيل - ( امر صورتي ) ')
end
if text == 'تفعيل صورتي' then
if not Owner(msg) then
return send(msg.chat_id_,msg.id_,'*• عذرآ هاذا الامر يخص : المنشئين فقط *')
end
redis:del(bot_id..'my_photo:status:bot'..msg.chat_id_)
return send(msg.chat_id_, msg.id_, '• تم تفعيل - ( امر صورتي ) ')
end

if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if redis:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'• المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'• لا اسطيع صيح معرفات القنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'• لا اسطيع صيح معرفات البوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'• لا اسطيع صيح معرفات المجموعات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'• تعال يبونك [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,' امر صيح تم تعطيله من قبل المدراء ') 
end
return false
end
if text and text:match("(.*)(ضافني)(.*)") then
if redis:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,' انت منشئ المجموعه ') 
return false
end
local Added_Me = redis:get(bot_id.."FDFGERB:Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '• هذا الي ضافك  ⇠ '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'• انت دخلت عبر الرابط ') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'• امر منو ضافني تم تعطيله من قبل المدراء ') 
end
end
if text == "صورتي" or text == 'افتاري' then
local my_ph = redis:get(bot_id..'my_photo:status:bot'..msg.chat_id_)
print(my_ph)
if not my_ph then
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_,msg.id_,result.photos_[0].sizes_[1].photo_.persistent_id_,'')
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك')
end 
end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
end

if text == "ضع رابط" and Admin(msg) or text == "وضع رابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"• ارسل رابط المجموعه او رابط قناة المجموعه")
redis:setex(bot_id.."FDFGERB:link:set"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false 
end
if text and text:match("^ضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 or text and text:match("^وضع صوره") and Admin(msg) and msg.reply_to_message_id_ == 0 then  
redis:set(bot_id.."FDFGERB:Set:Chat:Photo"..msg.chat_id_..":"..msg.sender_user_id_,true) 
send(msg.chat_id_,msg.id_,"• ارسل الصوره لوضعها") 
return false 
end
if text == "ضع وصف" and Admin(msg) or text == "وضع وصف" and Admin(msg) then  
redis:setex(bot_id.."FDFGERB:Change:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"• ارسل الان الوصف")
return false 
end
if text == "ضع ترحيب" and Admin(msg) or text == "وضع ترحيب" and Admin(msg) then  
redis:setex(bot_id.."FDFGERB:Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_,msg.id_,"• ارسل لي الترحيب الان".."\n• تستطيع اضافة مايلي !\n• دالة عرض الاسم »{`name`}\n• دالة عرض المعرف »{`user`}") 
return false 
end
if text == "ضع قوانين" and Admin(msg) or text == "وضع قوانين" and Admin(msg) then 
redis:setex(bot_id.."FDFGERB:Redis:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"• ارسل لي القوانين الان")  
return false 
end
if text and text:match("^ضع اسم (.*)") and Owner(msg) or text and text:match("^وضع اسم (.*)") and Owner(msg) then 
local Name = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"•  البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"•  ليست لدي صلاحية تغير اسم المجموعه")  
else
send(msg.chat_id_,msg.id_,"•  تم تغيير اسم المجموعه الى {["..Name.."]}")  
end
end,nil) 
return false 
end
if text == "الرابط" then 
local status_Link = redis:get(bot_id.."FDFGERB:Link_Group"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"• جلب الرابط معطل") 
return false  
end
local link = redis:get(bot_id.."FDFGERB:link:set:Group"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,"•  Link Chat :\n ["..link.."]")                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
send(msg.chat_id_,msg.id_,"•  Link Chat :\n ["..linkgpp.result.."]")                          
else
send(msg.chat_id_, msg.id_,"• لا يوجد رابط للمجموعه")              
end            
end
return false 
end
if text == "الترحيب" and Admin(msg) then 
if redis:get(bot_id.."FDFGERB:Get:Welcome:Group"..msg.chat_id_)   then 
Welcome = redis:get(bot_id.."FDFGERB:Get:Welcome:Group"..msg.chat_id_)  
else 
Welcome = "• لم يتم تعيين ترحيب للمجموعه"
end 
send(msg.chat_id_, msg.id_,"["..Welcome.."]") 
return false 
end
if text == "القوانين" then 
local Set_Rules = redis:get(bot_id.."FDFGERB::Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"• لا توجد قوانين هنا")   
end    
return false 
end
if text == "مسح الرابط" and Admin(msg) or text == "حذف الرابط" and Admin(msg) then
send(msg.chat_id_,msg.id_,"• تم ازالة رابط المجموعه")           
redis:del(bot_id.."FDFGERB:link:set:Group"..msg.chat_id_) 
return false 
end
if text == "حذف الصوره" and Admin(msg) or text == "مسح الصوره" and Admin(msg) then 
https.request("https://api.telegram.org/bot"..token.."/deleteChatPhoto?chat_id="..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"• تم ازالة صورة المجموعه") 
return false 
end
if text == "مسح الترحيب" and Admin(msg) or text == "حذف الترحيب" and Admin(msg) then 
redis:del(bot_id.."FDFGERB:Get:Welcome:Group"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"• تم ازالة ترحيب المجموعه") 
return false 
end
if text == "مسح القوانين" and Admin(msg) or text == "حذف القوانين" and Admin(msg) then  
send(msg.chat_id_, msg.id_,"• تم ازالة قوانين المجموعه")  
redis:del(bot_id.."FDFGERB::Rules:Group"..msg.chat_id_) 
return false 
end
if text == 'حذف الايدي' and Owner(msg) or text == 'مسح الايدي' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Set:Id:Group"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '• تم ازالة كليشة الايدي ')
return false 
end
if text == 'مسح رسائلي' then
redis:del(bot_id..'FDFGERB:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'• تم مسح جميع رسائلك ') 
return false 
end
if text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' then
redis:del(bot_id..'FDFGERB:Num:Message:Edit'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'• تم مسح جميع تعديلاتك ') 
return false 
end
if text == 'مسح جهاتي' then
redis:del(bot_id..'FDFGERB:Num:Add:Memp'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_, msg.id_,'• تم مسح جميع جهاتك المضافه ') 
return false 
end
if text ==("مسح") and Admin(msg) and tonumber(msg.reply_to_message_id_) > 0 then
Delete_Message(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, delbans, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
return false 
end
if text and text:match("^وضع تكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_ ,"Num:Spam" ,text:match("^وضع تكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"• تم وضع عدد التكرار : "..text:match("^وضع تكرار (%d+)$").."")  
return false 
end
if text and text:match("^وضع زمن التكرار (%d+)$") and Admin(msg) then   
redis:hset(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_ ,"Num:Spam:Time" ,text:match("^وضع زمن التكرار (%d+)$")) 
send(msg.chat_id_, msg.id_,"• تم وضع زمن التكرار : "..text:match("^وضع زمن التكرار (%d+)$").."") 
return false 
end
if text == "مسح قائمه المنع" and Admin(msg) then   
local list = redis:smembers(bot_id.."FDFGERB:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
redis:del(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_)  
redis:del(bot_id.."FDFGERB:Filter:Reply2"..v..msg.chat_id_)  
redis:srem(bot_id.."FDFGERB:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"• تم مسح قائمه المنع")  
return false 
end
if text == "قائمه المنع" and Admin(msg) then   
local list = redis:smembers(bot_id.."FDFGERB:List:Filter"..msg.chat_id_)  
t = "\n• قائمة المنع \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do  
local FilterMsg = redis:get(bot_id.."FDFGERB:Filter:Reply2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." » {"..FilterMsg.."}\n"    
end  
if #list == 0 then  
t = "• لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
return false 
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Admin(msg) then       
send(msg.chat_id_, msg.id_,"• ارسل الكلمه لمنعها")  
redis:set(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"SetFilter")  
return false  
end
if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Admin(msg) then    
send(msg.chat_id_, msg.id_,"• ارسل الكلمه الان")  
redis:set(bot_id.."FDFGERB:Filter:Reply1"..msg.sender_user_id_..msg.chat_id_,"DelFilter")  
return false 
end
if text ==("تثبيت") and msg.reply_to_message_id_ ~= 0 and Admin(msg) then
if redis:sismember(bot_id.."FDFGERB:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"• التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100",""),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"• تم تثبيت الرساله بنجاح")   
redis:set(bot_id.."FDFGERB:Get:Id:Msg:Pin"..msg.chat_id_,msg.reply_to_message_id_)
return false 
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"• البوت ليس ادمن هنا")  
return false 
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"• ليست لدي صلاحية التثبيت .")  
end;end,nil) 
return false 
end
if text == "الغاء التثبيت" and Admin(msg) then
if redis:sismember(bot_id.."FDFGERB:Lock:pin",msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"• التثبيت مقفل من قبل المنشئين")  
return false end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"• تم الغاء تثبيت الرساله بنجاح")   
redis:del(bot_id.."FDFGERB:Get:Id:Msg:Pin"..msg.chat_id_)
return false 
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"• البوت ليس ادمن هنا")  
return false 
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"• ليست لدي صلاحية التثبيت .")
end;end,nil)
return false 
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Admin(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
KickGroup(msg.chat_id_, data.id_)
end;end,nil);end
send(msg.chat_id_, msg.id_,'• تم طرد الحسابات المحذوفه')
end,nil)
end
return false 
end
if text ==("مسح المطرودين") and Admin(msg) then    
local function delbans(extra, result)  
if not msg.can_be_deleted_ == true then  
send(msg.chat_id_, msg.id_, "•  يرجى ترقيتي ادمن هنا") 
return false
end  
local num = 0 
for k,y in pairs(result.members_) do 
num = num + 1  
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft"}, }, dl_cb, nil)  
end  
send(msg.chat_id_, msg.id_,"•  تم الغاء الحظر عن *: "..num.." * شخص") 
end    
return false 
end
if text == "مسح البوتات" and Admin(msg) then 
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
KickGroup(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "• لا توجد بوتات في المجموعه")
else
send(msg.chat_id_, msg.id_,"\n• عدد البوتات هنا : "..c.."\n• عدد البوتات التي هي ادمن : "..x.."\n• تم طرد - "..(c - x).." - بوتات ") 
end 
end,nil)  
return false 
end
if text == ("كشف البوتات") and Admin(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n• قائمة البوتات \n━━━━━━━━━━━━━\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ""
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = " {★}"
end
text = text..": [@"..ta.username_.."]"..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "• لا توجد بوتات في المجموعه")
return false 
end
if #admins == i then 
local a = "\n━━━━━━━━━━━━━\n• عدد البوتات التي هنا : "..n.." بوت"
local f = "\n• عدد البوتات التي هي ادمن : "..t.."\n• ملاحضه علامة النجمه يعني البوت ادمن - ★ \n"
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
return false 
end

if text and text:match("^تنزيل الكل @(.*)$") and Owner(msg) then
function FunctionStatus(extra, result, success)
if (result.id_) then
if Dev_Bots_User(result.id_) == true then
send(msg.chat_id_, msg.id_,"•  لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."FDFGERB:Developer:Bot1",result.id_) then
dev = "المطور1 ،" else dev = "" end
if redis:sismember(bot_id.."FDFGERB:Developer:Bot",result.id_) then
dev = "المطور ،" else dev = "" end
if redis:sismember(bot_id.."FDFGERB:President:Group"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if redis:sismember(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if redis:sismember(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if redis:sismember(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if redis:sismember(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Rank_Checking(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n• تم تنزيل الشخص من الرتب التاليه \n•  { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n• ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_Bots_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."FDFGERB:Developer:Bot1", result.id_)
redis:srem(bot_id.."FDFGERB:Developer:Bot", result.id_)
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot1",msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.id_)
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.id_)
elseif redis:sismember(bot_id.."FDFGERB:President:Group"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.id_)
elseif redis:sismember(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, FunctionStatus, nil)
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_Bots_User(result.sender_user_id_) == true then
send(msg.chat_id_, msg.id_,"•  لا تستطيع تنزيل المطور الاساسي")
return false 
end
if redis:sismember(bot_id.."FDFGERB:Developer:Bot1",result.sender_user_id_) then
dev = "المطور1 ،" else dev = "" end
if redis:sismember(bot_id.."FDFGERB:Developer:Bot",result.sender_user_id_) then
dev = "المطور ،" else dev = "" end
if redis:sismember(bot_id.."FDFGERB:President:Group"..msg.chat_id_, result.sender_user_id_) then
crr = "منشئ اساسي ،" else crr = "" end
if redis:sismember(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.sender_user_id_) then
cr = "منشئ ،" else cr = "" end
if redis:sismember(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.sender_user_id_) then
own = "مدير ،" else own = "" end
if redis:sismember(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.sender_user_id_) then
mod = "ادمن ،" else mod = "" end
if redis:sismember(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.sender_user_id_) then
vip = "مميز ،" else vip = ""
end
if Rank_Checking(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n• تم تنزيل الشخص من الرتب التاليه \n•  { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n• ليس لديه رتب حتى استطيع تنزيله \n")
end
if Dev_Bots_User(msg.sender_user_id_) == true then
redis:srem(bot_id.."FDFGERB:Developer:Bot1", result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:Developer:Bot", result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot1",msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember(bot_id.."FDFGERB:Developer:Bot",msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:President:Group"..msg.chat_id_,result.sender_user_id_)
elseif redis:sismember(bot_id.."FDFGERB:President:Group"..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'FDFGERB:Constructor:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, result.sender_user_id_)
elseif redis:sismember(bot_id..'FDFGERB:Manager:Group'..msg.chat_id_, msg.sender_user_id_) then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, result.sender_user_id_)
redis:srem(bot_id..'FDFGERB:Vip:Group'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
return false end
if text == "رتبتي" then
local rtp = Get_Rank(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,"•  رتبتك في البوت : "..rtp)
return false end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = "•  اسمك الاول : `"..(result.first_name_).."`"
else
first_name = ""
end   
if result.last_name_ then 
last_name = "•  اسمك الثاني ← : `"..result.last_name_.."`" 
else
last_name = ""
end      
send(msg.chat_id_, msg.id_,first_name.."\n"..last_name) 
end,nil)
return false end
if text==("عدد الكروب") and Admin(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"•  البوت ليس ادمن هنا \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
local taha = "•  عدد الادمنيه : "..data.administrator_count_..
"\n•  عدد المطرودين : "..data.kicked_count_..
"\n•  عدد الاعضاء : "..data.member_count_..
"\n•  عدد رسائل الكروب : "..(msg.id_/2097152/0.5)..
"\n•  اسم المجموعه : ["..ta.title_.."]"
send(msg.chat_id_, msg.id_, taha) 
end,nil)end,nil)
end
if text == "غادر" then 
if DeveloperBot(msg) and not redis:get(bot_id.."FDFGERB:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"•  تم مغادرة المجموعه") 
redis:srem(bot_id.."FDFGERB:ChekBotAdd",msg.chat_id_)  
end
end
if text and text:match("^غادر (-%d+)$") then
local GP_ID = {string.match(text, "^(غادر) (-%d+)$")}
if DeveloperBot(msg) and not redis:get(bot_id.."FDFGERB:Lock:Left"..msg.chat_id_) then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=GP_ID[2],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,"•  تم مغادرة المجموعه") 
send(GP_ID[2], 0,"•  تم مغادرة المجموعه بامر من مطور البوت") 
redis:srem(bot_id.."FDFGERB:ChekBotAdd",GP_ID[2])  
end
end
if text == "الاعدادات" and Admin(msg) then    
if redis:get(bot_id.."FDFGERB:lockpin"..msg.chat_id_) then    
lock_pin = "{✔️}"
else 
lock_pin = "{✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:tagservr"..msg.chat_id_) then    
lock_tagservr = "{✔️}"
else 
lock_tagservr = "{✖}"
end
if redis:get(bot_id.."FDFGERB:Lock:text"..msg.chat_id_) then    
lock_text = "← {✔️}"
else 
lock_text = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:AddMempar"..msg.chat_id_) == "kick" then
lock_add = "← {✔️}"
else 
lock_add = "← {✖}"    
end    
if redis:get(bot_id.."FDFGERB:Lock:Join"..msg.chat_id_) == "kick" then
lock_join = "← {✔️}"
else 
lock_join = "← {✖}"    
end    
if redis:get(bot_id.."FDFGERB:Lock:edit"..msg.chat_id_) then    
lock_edit = "← {✔️}"
else 
lock_edit = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Chek:Welcome"..msg.chat_id_) then
welcome = "← {✔️}"
else 
welcome = "← {✖}"    
end
if redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_, "Spam:User") == "kick" then     
flood = "← { بالطرد }"     
elseif redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Spam:User") == "keed" then     
flood = "← { بالتقيد }"     
elseif redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Spam:User") == "mute" then     
flood = "← { بالكتم }"           
elseif redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Spam:User") == "del" then     
flood = "← {✔️}"
else     
flood = "← {✖}"     
end
if redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "del" then
lock_photo = "← {✔️}" 
elseif redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = "← { بالتقيد }"   
elseif redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = "← { بالطرد }"   
else
lock_photo = "← {✖}"   
end    
if redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "del" then
lock_phon = "← {✔️}" 
elseif redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = "← { بالطرد }"    
else
lock_phon = "← {✖}"    
end    
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "del" then
lock_links = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "ked" then
lock_links = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "ktm" then
lock_links = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) == "kick" then
lock_links = "← { بالطرد }"    
else
lock_links = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = "← { بالكتم }"   
elseif redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = "← { بالطرد }"    
else
lock_cmds = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "del" then
lock_user = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "ked" then
lock_user = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "ktm" then
lock_user = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) == "kick" then
lock_user = "← { بالطرد }"    
else
lock_user = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = "← { بالطرد }"    
else
lock_hash = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "del" then
lock_muse = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = "← { بالطرد }"    
else
lock_muse = "← {✖}"    
end 
if redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "del" then
lock_ved = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = "← { بالطرد }"    
else
lock_ved = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "del" then
lock_gif = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = "← { بالطرد }"    
else
lock_gif = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = "بالتقيد "    
elseif redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = "بالكتم "    
elseif redis:get(bot_id.."FDFGERB:Lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = "← { بالطرد }"    
else
lock_ste = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "del" then
lock_geam = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = "← { بالطرد }"    
else
lock_geam = "← {✖}"    
end    
if redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "del" then
lock_vico = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = "← { بالطرد }"    
else
lock_vico = "← {✖}"    
end    
if redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = "← { بالتقيد }"
elseif redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = "← { بالطرد }"
else
lock_inlin = "← {✖}"
end
if redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "del" then
lock_fwd = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = "← { بالطرد }"    
else
lock_fwd = "← {✖}"    
end    
if redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "del" then
lock_file = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "ked" then 
lock_file = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Document"..msg.chat_id_) == "kick" then 
lock_file = "← { بالطرد }"    
else
lock_file = "← {✖}"    
end    
if redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = "← { بالطرد }"    
else
lock_self = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_) == "del" then
lock_bots = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_) == "ked" then
lock_bots = "← { بالتقيد }"   
elseif redis:get(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_) == "kick" then
lock_bots = "← { بالطرد }"    
else
lock_bots = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = "← { بالطرد }"    
else
lock_mark = "← {✖}"    
end
if redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = "← {✔️}"
elseif redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = "← { بالتقيد }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = "← { بالكتم }"    
elseif redis:get(bot_id.."FDFGERB:Lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = "← { بالطرد }"    
else
lock_spam = "← {✖}"    
end        
if not redis:get(bot_id.."FDFGERB:Reply:Manager"..msg.chat_id_) then
ReplyManager = "← {✔️}"
else
ReplyManager = "← {✖}"
end
if not redis:get(bot_id.."FDFGERB:Reply:Sudo"..msg.chat_id_) then
ReplySudo = "← {✔️}"
else
ReplySudo = "← {✖}"
end
if not redis:get(bot_id.."FDFGERB:Lock:Id:Photo"..msg.chat_id_)  then
IdPhoto = "← {✔️}"
else
IdPhoto = "← {✖}"
end
if not redis:get(bot_id.."FDFGERB:Lock:Id:Py:Photo"..msg.chat_id_) then
IdPyPhoto = "← {✔️}"
else
IdPyPhoto = "← {✖}"
end
if not redis:get(bot_id.."FDFGERB:Cheking:Kick:Me:Group"..msg.chat_id_)  then
KickMe = "← {✔️}"
else
KickMe = "← {✖}"
end
if not redis:get(bot_id.."FDFGERB:Lock:Ban:Group"..msg.chat_id_)  then
Banusers = "← {✔️}"
else
Banusers = "← {✖}"
end
if not redis:get(bot_id.."FDFGERB:Cheking:Seted"..msg.chat_id_) then
Setusers = "← {✔️}"
else
Setusers = "← {✖}"
end
if redis:get(bot_id.."FDFGERB:Link_Group"..msg.chat_id_) then
Link_Group = "← {✔️}"
else
Link_Group = "← {✖}"
end
if not redis:get(bot_id.."FDFGERB:Fun:Group"..msg.chat_id_) then
FunGroup = "← {✔️}"
else
FunGroup = "← {✖}"
end
local Num_Flood = redis:hget(bot_id.."FDFGERB:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 0
send(msg.chat_id_, msg.id_,"*\n• اعدادات المجموعه "..
"\n━━━━━━━━━━━━━"..
"\n🔏┇علامة ال (✔️) تعني مفعل"..
"\n🔓┇علامة ال (✖) تعني معطل"..
"\n━━━━━━━━━━━━━"..
"\n• الروابط "..lock_links..
"\n".."• الكلايش "..lock_spam..
"\n".."• الكيبورد "..lock_inlin..
"\n".."• الاغاني "..lock_vico..
"\n".."• المتحركه "..lock_gif..
"\n".."• الملفات "..lock_file..
"\n".."• الدردشه "..lock_text..
"\n".."• الفيديو "..lock_ved..
"\n".."• الصور "..lock_photo..
"\n━━━━━━━━━━━━━"..
"\n".."• المعرفات  "..lock_user..
"\n".."• التاك "..lock_hash..
"\n".."• البوتات "..lock_bots..
"\n".."• التوجيه "..lock_fwd..
"\n".."• الصوت "..lock_muse..
"\n".."• الملصقات "..lock_ste..
"\n".."• الجهات "..lock_phon..
"\n".."• الدخول "..lock_join..
"\n".."• الاضافه "..lock_add..
"\n".."• السيلفي "..lock_self..
"\n━━━━━━━━━━━━━"..
"\n".."• التثبيت "..lock_pin..
"\n".."• الاشعارات "..lock_tagservr..
"\n".."• الماركدون "..lock_mark..
"\n".."• التعديل "..lock_edit..
"\n".."• الالعاب "..lock_geam..
"\n".."• التكرار "..flood..
"\n━━━━━━━━━━━━━"..
"\n".."• الترحيب "..welcome..
"\n".."• الرفع "..Setusers..
"\n".."• الطرد "..Banusers..
"\n".."• الايدي "..IdPhoto..
"\n".."• الايدي بالصوره "..IdPyPhoto..
"\n".."• اطردني "..KickMe..
"\n".."• ردود المدير "..ReplyManager..
"\n".."• ردود المطور "..ReplySudo..
"\n".."• اوامر التحشيش "..FunGroup..
"\n".."• جلب الرابط "..Link_Group..
"\n".."• عدد التكرار ← {"..Num_Flood.."}\n\n.*")     
end
if text and text:match('^تنظيف (%d+)$') and Admin(msg) or text and text:match('^حذف (%d+)$') and Admin(msg) or text and text:match('^مسح (%d+)$') and Admin(msg) then    
local Msg_Num = tonumber(text:match('^تنظيف (%d+)$')) or tonumber(text:match('^حذف (%d+)$'))  or tonumber(text:match('^مسح (%d+)$')) 
if Msg_Num > 1000 then 
send(msg.chat_id_, msg.id_,'• تستطيع حذف *(1000)* رساله فقط') 
return false  
end  
local Message = msg.id_
for i=1,tonumber(Msg_Num) do
Delete_Message(msg.chat_id_,{[0]=Message})
Message = Message - 1048576
end
send(msg.chat_id_, msg.id_,'• تم ازالة *- '..Msg_Num..'* رساله من المجموعه')  
end

if text and text:match("^تغير رد المطور (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
redis:set(bot_id.."FDFGERB:Developer:Bot:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد المطور الى :"..Teext)
return false end
if text and text:match("^تغير رد المنشئ الاساسي (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المنشئ الاساسي (.*)$") 
redis:set(bot_id.."FDFGERB:President:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد المنشئ الاساسي الى :"..Teext)
return false end
if text and text:match("^تغير رد المنشئ (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
redis:set(bot_id.."FDFGERB:Constructor:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد المنشئ الى :"..Teext)
return false end
if text and text:match("^تغير رد المدير (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
redis:set(bot_id.."FDFGERB:Manager:Group:Reply"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"•  تم تغير رد المدير الى :"..Teext)
return false end
if text and text:match("^تغير رد الادمن (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
redis:set(bot_id.."FDFGERB:Admin:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد الادمن الى :"..Teext)
return false end
if text and text:match("^تغير رد المميز (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
redis:set(bot_id.."FDFGERB:Vip:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد المميز الى :"..Teext)
return false end
if text and text:match("^تغير رد العضو (.*)$") and Owner(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
redis:set(bot_id.."FDFGERB:Mempar:Group:Reply"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"•  تم تغير رد العضو الى :"..Teext)
return false end
if text == 'حذف رد المطور' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Developer:Bot:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حدف رد المطور")
return false end
if text == 'حذف رد المنشئ الاساسي' and Owner(msg) then
redis:del(bot_id.."FDFGERB:President:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد المنشئ الاساسي ")
return false end
if text == 'حذف رد المنشئ' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Constructor:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد المنشئ ")
return false end
if text == 'حذف رد المدير' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Manager:Group:Reply"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"• تم حذف رد المدير ")
return false end
if text == 'حذف رد الادمن' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Admin:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد الادمن ")
return false end
if text == 'حذف رد المميز' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Vip:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد المميز")
return false end
if text == 'حذف رد العضو' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Mempar:Group:Reply"..msg.chat_id_)
send(msg.chat_id_, msg.id_,"• تم حذف رد العضو")
return false 
end

if text == ("مسح ردود المدير") and Owner(msg) then
local list = redis:smembers(bot_id.."FDFGERB:List:Manager"..msg.chat_id_.."")
for k,v in pairs(list) do
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Gif"..v..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Vico"..v..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Text"..v..msg.chat_id_)   
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Photo"..v..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Video"..v..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:File"..v..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Add:Rd:Manager:Audio"..v..msg.chat_id_)
redis:del(bot_id.."FDFGERB:List:Manager"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"• تم مسح قائمه ردود المدير")
return false 
end
if text == ("ردود المدير") and Owner(msg) then
local list = redis:smembers(bot_id.."FDFGERB:List:Manager"..msg.chat_id_.."")
text = "• قائمه ردود المدير \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = "متحركه 🎭"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = "بصمه 📢"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = "ملصق 🃏"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = "رساله ✉"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = "صوره 🎇"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = "فيديو 📹"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Manager:File"..v..msg.chat_id_) then
db = "ملف 📁"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = "اغنيه 🎵"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "• عذرا لا يوجد ردود للمدير في المجموعه"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
return false 
end
if text == "الصلاحيات" and Admin(msg) then 
local list = redis:smembers(bot_id.."FDFGERB:Validitys:Group"..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,"• لا توجد صلاحيات مضافه هنا")
return false
end
Validity = "\n• قائمة الصلاحيات المضافه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
var = redis:get(bot_id.."FDFGERB:Add:Validity:Group:Rt"..v..msg.chat_id_)
if var then
Validity = Validity..""..k.."- "..v.." ~ ("..var..")\n"
else
Validity = Validity..""..k.."- "..v.."\n"
end
end
send(msg.chat_id_, msg.id_,Validity)
end
if text == "الاوامر المضافه" and Constructor(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Command:List:Group"..msg.chat_id_.."")
Command = "• قائمه الاوامر المضافه  \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
Commands = redis:get(bot_id.."FDFGERB:Get:Reides:Commands:Group"..msg.chat_id_..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "• لا توجد اوامر اضافيه"
end
send(msg.chat_id_, msg.id_,"["..Command.."]")
end
if text == "حذف الاوامر المضافه" and Constructor(msg) or text == "مسح الاوامر المضافه" and Constructor(msg) then 
local list = redis:smembers(bot_id.."FDFGERB:Command:List:Group"..msg.chat_id_)
for k,v in pairs(list) do
redis:del(bot_id.."FDFGERB:Get:Reides:Commands:Group"..msg.chat_id_..":"..v)
redis:del(bot_id.."FDFGERB:Command:List:Group"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"• تم مسح جميع الاوامر التي تم اضافتها")  
end
if text == "مسح الصلاحيات" and Constructor(msg) then
local list = redis:smembers(bot_id.."FDFGERB:Validitys:Group"..msg.chat_id_)
for k,v in pairs(list) do;redis:del(bot_id.."FDFGERB:Add:Validity:Group:Rt"..v..msg.chat_id_);redis:del(bot_id.."FDFGERB:Validitys:Group"..msg.chat_id_);end
send(msg.chat_id_, msg.id_,"• تم مسح صلاحيات المجموعه")
end
if text == "اضف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لاضافتها في ردود المدير ")
redis:set(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد" and Owner(msg) then
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لحذفها من ردود المدير")
redis:set(bot_id.."FDFGERB:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
return false 
end
if text == ("مسح ردود المطور") and DeveloperBot1(msg) then 
local list = redis:smembers(bot_id.."FDFGERB:List:Rd:Sudo")
for k,v in pairs(list) do
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:Gif"..v)   
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:vico"..v)   
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:stekr"..v)     
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:Text"..v)   
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:Photo"..v)
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:Video"..v)
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:File"..v)
redis:del(bot_id.."FDFGERB:Add:Rd:Sudo:Audio"..v)
redis:del(bot_id.."FDFGERB:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"• تم حذف ردود المطور")
return false 
end
if text == ("ردود المطور") and DeveloperBot1(msg) then 
local list = redis:smembers(bot_id.."FDFGERB:List:Rd:Sudo")
text = "\n• قائمة ردود المطور \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
if redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🃏"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:Photo"..v) then
db = "صوره 🎇"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:File"..v) then
db = "ملف 📁"
elseif redis:get(bot_id.."FDFGERB:Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "• لا توجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
return false 
end
if text == "اضف رد عام" and DeveloperBot1(msg) then 
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لاضافتها في ردود المكور ")
redis:set(bot_id.."FDFGERB:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد عام" and DeveloperBot1(msg) then 
send(msg.chat_id_, msg.id_,"• ارسل الان الكلمه لحذفها من ردود المطور")
redis:set(bot_id.."FDFGERB:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "اضف امر" and Constructor(msg) then
redis:set(bot_id.."FDFGERB:Command:Reids:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"• الان ارسل لي الامر القديم ...")  
return false 
end
if text == "حذف امر" and Constructor(msg) or text == "مسح امر" and Constructor(msg) then 
redis:set(bot_id.."FDFGERB:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
send(msg.chat_id_, msg.id_,"• ارسل الان الامر الذي قمت بوضعه مكان الامر القديم")  
return false 
end
if text and text:match("^مسح صلاحيه (.*)$") and Admin(msg) or text and text:match("^حذف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^مسح صلاحيه (.*)$") or text:match("^حذف صلاحيه (.*)$")
redis:del(bot_id.."FDFGERB:Add:Validity:Group:Rt"..ComdNew..msg.chat_id_)
redis:srem(bot_id.."FDFGERB:Validitys:Group"..msg.chat_id_,ComdNew)  
send(msg.chat_id_, msg.id_, "\n• تم مسح ← { "..ComdNew..' } من الصلاحيات') 
return false 
end
if text and text:match("^اضف صلاحيه (.*)$") and Admin(msg) then 
local ComdNew = text:match("^اضف صلاحيه (.*)$")
redis:set(bot_id.."FDFGERB:Add:Validity:Group:Rt:New"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
redis:sadd(bot_id.."FDFGERB:Validitys:Group"..msg.chat_id_,ComdNew)  
redis:setex(bot_id.."FDFGERB:Redis:Validity:Group"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "\n• ارسل نوع الصلاحيه كما مطلوب منك :\n• انواع الصلاحيات المطلوبه ← { عضو ، مميز  ، ادمن  ، مدير }") 
return false 
end
if text == 'وضع كليشه المطور' and Dev_Bots(msg) then
redis:set(bot_id..'FDFGERB:GetTexting:DevSlbotss'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'•  ارسل لي الكليشه الان')
return false 
end
if text == 'حذف كليشه المطور' and Dev_Bots(msg) then
redis:del(bot_id..'FDFGERB:Texting:DevSlbotss')
send(msg.chat_id_, msg.id_,'•  تم حذف كليشه المطور')
end
if text == (redis:get(bot_id.."FDFGERB:Redis:Name:Bot") or "ستورم") then
local namebot = {
"عمر "..(redis:get(bot_id.."FDFGERB:Redis:Name:Bot") or "ستورم").. " شتريد؟",
"أჂ̤ أჂ̤ هياتني اني",
"موجود بس لتصيح",
"لتــلح دا احجي ويه بنات ستورم بعدين اجاوبك",
"راح نموت بكورونا ونته بعدك تصيح "..(redis:get(bot_id.."FDFGERB:Redis:Name:Bot") or "ستورم"),
'يمعود والله نعسان'
}
name = math.random(#namebot)
send(msg.chat_id_, msg.id_, namebot[name]) 
end
if text == "بوت" then
local BotName = {
"باوع لك خليني احبك وصيحلي باسمي "..(redis:get(bot_id.."FDFGERB:Redis:Name:Bot") or "ستورم").. "",
"لتخليني ارجع لحركاتي لقديمه وردا ترا اسمي "..(redis:get(bot_id.."FDFGERB:Redis:Name:Bot") or "ستورم").. "",
"راح نموت بكورونا ونته بعدك تصيح بوت"
}
BotNameText = math.random(#BotName)
send(msg.chat_id_, msg.id_,BotName[BotNameText]) 
end
if text == "تغير اسم البوت" and Dev_Bots(msg) or text == "تغيير اسم البوت" and Dev_Bots(msg) then 
redis:setex(bot_id.."FDFGERB:Change:Name:Bot"..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"•  ارسل لي الاسم الان ")  
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."FDFGERB:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."FDFGERB:Broadcasting:Users" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and DeveloperBot(msg) then 
if redis:get(bot_id.."FDFGERB:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."FDFGERB:Broadcasting:Groups" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي المنشور الان\n• يمكنك ارسال -{ صوره - ملصق - متحركه - رساله }\n• لالغاء الاذاعه ارسل : الغاء") 
return false
end
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."FDFGERB:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."FDFGERB:Broadcasting:Groups:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم نشره في المجموعات") 
return false
end
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and DeveloperBot(msg) then 
if redis:get(bot_id.."FDFGERB:Broadcasting:Bot") and not Dev_Bots(msg) then 
send(msg.chat_id_, msg.id_,"• تم تعطيل الاذاعه من قبل المطور الاساسي !")
return false end
redis:setex(bot_id.."FDFGERB:Broadcasting:Users:Fwd" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"• ارسل لي التوجيه الان\n• ليتم نشره الى المشتركين") 
return false
end
if text == 'تعين الايدي' and Owner(msg) then
redis:setex(bot_id.."FDFGERB:Redis:Id:Group"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
send(msg.chat_id_, msg.id_,[[
• ارسل الان النص
• يمكنك اضافه :
• `#username` » اسم المستخدم
• `#msgs` » عدد الرسائل
• `#photos` » عدد الصور
• `#id` » ايدي المستخدم
• `#auto` » نسبة التفاعل
• `#stast` » رتبة المستخدم 
• `#edit` » عدد السحكات
• `#game` » عدد المجوهرات
• `#AddMem` » عدد الجهات
• `#Description` » تعليق الصوره
]])
return false  
end 
if text == "سمايلات" or text == "سمايل" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."FDFGERB:Set:Sma"..msg.chat_id_)
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","??","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","🇮🇶","⚔","🛡","🔮","🌡","💣","📌","📍","📓","📗","📂","📅","📪","📫","📬","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
redis:set(bot_id.."FDFGERB:Random:Sm"..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,"• اسرع واحد يدز هاذا السمايل ? ~ {`"..SM.."`}")
return false
end
end
if text == "الاسرع" or tect == "ترتيب" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."FDFGERB:Speed:Tr"..msg.chat_id_)
KlamSpeed = {"سحور","سياره","استقبال","قنفه","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","كهوه","سفينه","العراق","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","بتيته","لهانه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنيت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
redis:set(bot_id.."FDFGERB:Klam:Speed"..msg.chat_id_,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفه","ه ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"بزونه","ز و ه ن")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"كهوه","ه ك ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"العراق","ق ع ا ل ر ا")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"بتيته","ب ت ت ي ه")
name = string.gsub(name,"لهانه","ه ن ل ه ل")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنيت","ا ت ن ر ن ي ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
send(msg.chat_id_, msg.id_,"• اسرع واحد يرتبها ~ {"..name.."}")
return false
end
end
if text == "حزوره" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."FDFGERB:Set:Hzora"..msg.chat_id_)
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
redis:set(bot_id.."FDFGERB:Klam:Hzor"..msg.chat_id_,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
send(msg.chat_id_, msg.id_,"• اسرع واحد يحل الحزوره ↓\n {"..name.."}")
return false
end
end
if text == "معاني" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."FDFGERB:Set:Maany"..msg.chat_id_)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
redis:set(bot_id.."FDFGERB:Maany"..msg.chat_id_,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","??")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
send(msg.chat_id_, msg.id_,"• اسرع واحد يدز معنى السمايل ~ {"..name.."}")
return false
end
end
if text == "العكس" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
redis:del(bot_id.."FDFGERB:Set:Aks"..msg.chat_id_)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
redis:set(bot_id.."FDFGERB:Set:Aks:Game"..msg.chat_id_,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"ناصي","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
send(msg.chat_id_, msg.id_,"• اسرع واحد يدز العكس ~ {"..name.."}")
return false
end
end
if text == "خمن" or text == "تخمين" then   
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
Num = math.random(1,20)
redis:set(bot_id.."FDFGERB:GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,"\n• اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."• ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."• سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ")
redis:setex(bot_id.."FDFGERB:GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end
if text == "محيبس" or text == "بات" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then   
Num = math.random(1,6)
redis:set(bot_id.."FDFGERB:Games:Bat"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,[[
*➀       ➁     ➂      ➃      ➄     ➅
↓      ↓     ↓      ↓     ↓     ↓
👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊 ‹› 👊
• اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
• الفائز يحصل على { 3 } من النقاط *
]])
redis:setex(bot_id.."FDFGERB:SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end
if text == "المختلف" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","🧜‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
redis:del(bot_id.."FDFGERB:Set:Moktlf:Bot"..msg.chat_id_)
redis:set(bot_id.."FDFGERB::Set:Moktlf"..msg.chat_id_,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹😹😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻??👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍💻👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","??‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
send(msg.chat_id_, msg.id_,"• اسرع واحد يدز الاختلاف ~ {"..name.."}")
return false
end
end
if text == "امثله" then
if redis:get(bot_id.."FDFGERB:Lock:Game:Group"..msg.chat_id_) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
redis:set(bot_id.."FDFGERB:Set:Amth"..msg.chat_id_,name)
redis:del(bot_id.."FDFGERB:Set:Amth:Bot"..msg.chat_id_)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
send(msg.chat_id_, msg.id_,"• اسرع واحد يكمل المثل ~ {"..name.."}")
return false
end
end
if text == 'رسائلي' then
local nummsg = redis:get(bot_id..'FDFGERB:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 1
send(msg.chat_id_, msg.id_,'• عدد رسائلك هنا *~ '..nummsg..'*') 
end
if text == 'سحكاتي' or text == 'تعديلاتي' then
local edit = redis:get(bot_id..'FDFGERB:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'• عدد التعديلات هنا *~ '..edit..'*') 
end
if text == 'جهاتي' then
local addmem = redis:get(bot_id.."FDFGERB:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
send(msg.chat_id_, msg.id_,'• عدد جهاتك المضافه هنا *~ '..addmem..'*') 
end
if text == "مجوهراتي" then 
local Num = redis:get(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = "• لم تفز بأي مجوهره "
else
Text = "• عدد الجواهر التي ربحتها *← "..Num.." *"
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع مجوهراتي (%d+)$") then
local NUMPY = text:match("^بيع مجوهراتي (%d+)$") 
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*• لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(redis:get(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,"• ليس لديك جواهر من الالعاب \n• اذا كنت تريد ربح الجواهر \n• ارسل الالعاب وابدأ اللعب ! ") 
else
local NUM_GAMES = redis:get(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,"\n• ليس لديك جواهر بهاذا العدد \n• لزيادة مجوهراتك في اللعبه \n• ارسل الالعاب وابدأ اللعب !") 
return false 
end
local NUMNKO = (NUMPY * 50)
redis:decrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_,NUMPY)  
redis:incrby(bot_id.."FDFGERB:Num:Message:User"..msg.chat_id_..":"..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,"• تم خصم *~ { "..NUMPY.." }* من مجوهراتك \n• وتم اضافة* ~ { "..(NUMPY * 50).." } رساله الى رسالك *")
end 
return false 
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
taha = text:match("^اضف رسائل (%d+)$")
redis:set(bot_id.."FDFGERB:id:user"..msg.chat_id_,taha)  
redis:setex(bot_id.."FDFGERB:Add:msg:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "• ارسل لي عدد الرسائل الان") 
return false
end
if text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
taha = text:match("^اضف مجوهرات (%d+)$")
redis:set(bot_id.."FDFGERB:idgem:user"..msg.chat_id_,taha)  
redis:setex(bot_id.."FDFGERB:gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, "• ارسل لي عدد المجوهرات الان") 
end
if text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:incrby(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..result.sender_user_id_,text:match("^اضف مجوهرات (%d+)$"))  
send(msg.chat_id_, msg.id_,"• تم اضافه عدد مجوهرات : "..text:match("^اضف مجوهرات (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function reply(extra, result, success)
redis:del(bot_id.."FDFGERB:Msg_User"..msg.chat_id_..":"..result.sender_user_id_) 
redis:incrby(bot_id.."FDFGERB:Num:Message:User"..msg.chat_id_..":"..result.sender_user_id_,text:match("^اضف رسائل (%d+)$"))  
send(msg.chat_id_, msg.id_, "• تم اضافه عدد الرسائل : "..text:match("^اضف رسائل (%d+)$").." ")  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == "تنظيف المشتركين" and Dev_Bots(msg) then
local pv = redis:smembers(bot_id..'FDFGERB:Num:User:Pv')  
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
redis:srem(bot_id..'FDFGERB:Num:User:Pv',pv[i])  
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'• لا يوجد مشتركين وهميين')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'*• عدد المشتركين الان ←{ '..#pv..' }\n• تم العثور على ←{ '..sendok..' } مشترك قام بحظر البوت\n• اصبح عدد المشتركين الان ←{ '..ok..' } مشترك *')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات" and Dev_Bots(msg) then
local group = redis:smembers(bot_id..'FDFGERB:ChekBotAdd')  
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'• لا توجد مجموعات وهميه ')   
else
local taha = (w + q)
local sendok = #group - taha
if q == 0 then
taha = ''
else
taha = '\n•  تم ازالة ~ '..q..' مجموعات من البوت'
end
if w == 0 then
groupss = ''
else
groupss = '\n•  تم ازالة ~'..w..' مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'*•  عدد المجموعات الان ← { '..#group..' } مجموعه '..groupss..''..taha..'\n• اصبح عدد المجموعات الان ← { '..sendok..' } مجموعات*\n')   
end
end
end,nil)
end
end
if text == "اطردني" or text == "طردني" then
if not redis:get(bot_id.."FDFGERB:Cheking:Kick:Me:Group"..msg.chat_id_) then
if Rank_Checking(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, "\n•  عذرا لا استطيع طرد ( "..Get_Rank(msg.sender_user_id_,msg.chat_id_).." )")
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,"•  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,"•  البوت ليس ادمن يرجى ترقيتي !") 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,"•  عذرا لا استطيع طرد ادمنية المجموعه") 
return false  
end
if data and data.ID and data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"•  تم طردك من المجموعه ") 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,"•  امر اطردني تم تعطيله من قبل المدراء ") 
end
end
if text and text:match("^رفع القيود @(.*)") and Owner(msg) then 
local username = text:match("^رفع القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if Dev_Bots(msg) then
redis:srem(bot_id.."FDFGERB:Removal:User:Groups",result.id_)
redis:srem(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."FDFGERB:Silence:User:Groups"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n•  تم الغاء القيود عنه")  
else
redis:srem(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.id_)
redis:srem(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.id_)
Send_Options(msg,result.id_,"reply","\n•  تم الغاء القيود عنه")  
end
else
send(msg.chat_id_, msg.id_,"•  المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
end
if text == "رفع القيود" and Owner(msg) then
function Function_Status(extra, result, success)
if Dev_Bots(msg) then
redis:srem(bot_id.."FDFGERB:Removal:User:Groups",result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:Silence:User:Groups"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n•  تم الغاء القيود عنه")  
else
redis:srem(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.sender_user_id_)
redis:srem(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.sender_user_id_)
Send_Options(msg,result.sender_user_id_,"reply","\n•  تم الغاء القيود عنه")  
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
end
if text and text:match("^كشف القيود @(.*)") and Owner(msg) then 
local username = text:match("^كشف القيود @(.*)") 
function Function_Status(extra, result, success)
if result.id_ then
if redis:sismember(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."FDFGERB:Removal:User:Groups",result.id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
if redis:sismember(bot_id.."FDFGERB:Silence:User:Groups",result.id_) then
GBanss = "مكتوم عام"
else
GBanss = "غير مكتوم عام"
end
send(msg.chat_id_, msg.id_,"•  كتم العام ← "..GBanss.."\n•  الحظر العام ← "..GBan.."\n•  الحظر ← "..Ban.."\n•  الكتم ← "..Muted)
else
send(msg.chat_id_, msg.id_,"•  المعرف غلط")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
end
if text == "كشف القيود" and Owner(msg) then 
function Function_Status(extra, result, success)
if redis:sismember(bot_id.."FDFGERB:Silence:User:Group"..msg.chat_id_,result.sender_user_id_) then
Muted = "مكتوم"
else
Muted = "غير مكتوم"
end
if redis:sismember(bot_id.."FDFGERB:Removal:User:Group"..msg.chat_id_,result.sender_user_id_) then
Ban = "محظور"
else
Ban = "غير محظور"
end
if redis:sismember(bot_id.."FDFGERB:Removal:User:Groups",result.sender_user_id_) then
GBan = "محظور عام"
else
GBan = "غير محظور عام"
end
if redis:sismember(bot_id.."FDFGERB:Silence:User:Groups",result.sender_user_id_) then
GBanss = "مكتوم عام"
else
GBanss = "غير مكتوم عام"
end
send(msg.chat_id_, msg.id_,"•  كتم العام ← "..GBanss.."\n•  الحظر العام ← "..GBan.."\n•  الحظر ← "..Ban.."\n•  الكتم ← "..Muted)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
end
if text ==("رفع الادمنيه") and Owner(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
redis:sadd(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
redis:srem(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
redis:sadd(bot_id..'FDFGERB:Admin:Group'..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"•  لا توجد ادمنية ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"•  تمت ترقية - "..num2.." من ادمنية المجموعه") 
end
end,nil)   
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"•  حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "tahaj20")
send(msg.chat_id_, msg.id_,"• منشئ المجموعه ~ ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text ==("رفع المنشئ") and DeveloperBot(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"• حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "tahaj20")
send(msg.chat_id_, msg.id_,"• تم ترقية منشئ المجموعه ← ["..b.first_name_.."](T.me/"..UserName..")")  
redis:sadd(bot_id.."FDFGERB:President:Group"..msg.chat_id_,b.id_)
end,nil)   
end,nil)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") and Dev_Bots(msg) then
redis:set(bot_id..'FDFGERB:Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg.chat_id_, msg.id_,'*•  تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *')
end

if text and text:match("^تغير الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text and text:match("^تغير رساله الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي النص الذي تريده') 
return false  
end
if text == "حذف رساله الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "• تم مسح رساله الاشتراك ") 
return false  
end
if text and text:match("^وضع قناة الاشتراك$") then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '• حسنا ارسل لي معرف القناة') 
return false  
end
if text == "تفعيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
if redis:get(bot_id..'add:ch:id') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"• الاشتراك الاجباري مفعل \n على القناة ⇠ ["..addchusername.."]")
else
redis:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," لا يوجد قناة للاشتراك الاجباري")
end
return false  
end
if text == "تعطيل الاشتراك" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id..'add:ch:id')
redis:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تعطيل الاشتراك الاجباري ") 
return false  
end
if text == "الاشتراك الاجباري" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
if redis:get(bot_id..'add:ch:username') then
local addchusername = redis:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "• تم تفعيل الاشتراك الاجباري \n على القناة ⇠ ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "• لا يوجد قناة في الاشتراك الاجباري ") 
end
return false  
end

if text == "اضف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:set(bot_id.."FDFGERB:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال كت تويت" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id.."FDFGERB:gamebot:List:Manager")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."FDFGERB:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."FDFGERB:gamebot:Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."FDFGERB:gamebot:List:Manager", text)
return false end
end
if text == 'كت تويت' then
if redis:get(bot_id..'Lock:Games'..msg.chat_id_) then
local list = redis:smembers(bot_id.."FDFGERB:gamebot:List:Manager")
if #list ~= 0 then
local quschen = list[math.random(#list)]
send(msg.chat_id_, msg.id_,quschen)
end
end
end

if text == "اضف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"ارسل السؤال الان ")
end
if text == "حذف سوال مقالات" then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id.."makal:bots")
return send(msg.chat_id_, msg.id_,"تم حذف الاسئله")
end
if text and text:match("^(.*)$") then
if redis:get(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\nتم حفظ السؤال بنجاح')
redis:set(bot_id.."makal:bots:set"..msg.sender_user_id_..":"..msg.chat_id_,"true1uu")
redis:sadd(bot_id.."makal:bots", text)
return false end
end
if text == 'مقالات' then
local list = redis:smembers(bot_id.."makal:bots")
if #list ~= 0 then
quschen = list[math.random(#list)]
quschen1 = string.gsub(quschen,"-"," ")
quschen1 = string.gsub(quschen1,"*"," ")
quschen1 = string.gsub(quschen1,"•"," ")
quschen1 = string.gsub(quschen1,"_"," ")
quschen1 = string.gsub(quschen1,","," ")
quschen1 = string.gsub(quschen1,"/"," ")
print(quschen1)
send(msg.chat_id_, msg.id_,'['..quschen..']')
redis:set(bot_id.."makal:bots:qus"..msg.chat_id_,quschen1)
redis:setex(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 60, true) 
end
end
if text == ""..(redis:get(bot_id.."makal:bots:qus"..msg.chat_id_) or '').."" then
local timemkall = redis:ttl(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
local timemkal = (60 - timemkall)
if tonumber(timemkal) == 1 then
send(msg.chat_id_, msg.id_,' ❍ استمر ي وحش ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 2 then
send(msg.chat_id_, msg.id_,' ❍ اكيد محد ينافسك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 3 then
send(msg.chat_id_, msg.id_,' ❍ اتوقع محد ينافسك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 4 then
send(msg.chat_id_, msg.id_,' ❍ مركب تيربو !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 5 then
send(msg.chat_id_, msg.id_, ' ❍ صح عليك !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 6 then
send(msg.chat_id_, msg.id_,'  ❍ صحيح !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 7 then
send(msg.chat_id_, msg.id_,'  ❍ شد حيلك ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 8 then
send(msg.chat_id_, msg.id_, ' ❍ عندك اسرع ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 9 then
send(msg.chat_id_, msg.id_,'  ❍ يجي ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 10 then
send(msg.chat_id_, msg.id_,'  ❍ كفو ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 11 then
send(msg.chat_id_, msg.id_,'  ❍ ماش !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 12 then
send(msg.chat_id_, msg.id_,'  ❍ مستوى مستوى !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 13 then
send(msg.chat_id_, msg.id_,'  ❍ تدرب ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 14 then
send(msg.chat_id_, msg.id_,'  ❍ مدري وش اقول ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 15 then
send(msg.chat_id_, msg.id_,'  ❍ بطه ! \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 16 then
send(msg.chat_id_, msg.id_,'  ❍ ي بطوط !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 17 then
send(msg.chat_id_, msg.id_,'  ❍ مافي اسرع  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 18 then
send(msg.chat_id_, msg.id_,'  ❍ بكير  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 19 then
send(msg.chat_id_, msg.id_,'  ❍ وش هذا !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 20 then
send(msg.chat_id_, msg.id_,'  ❍ الله يعينك !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 21 then
send(msg.chat_id_, msg.id_,'  ❍ كيبوردك يعلق ههههه  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 22 then
send(msg.chat_id_, msg.id_,'  ❍ يبي لك تدريب  !  \n عدد الثواني {'..timemkal..'}')
elseif tonumber(timemkal) == 23 then
send(msg.chat_id_, msg.id_,'  ❍ انت اخر واحد رسلت وش ذا !  \n عدد الثواني {'..timemkal..'}')
else
send(msg.chat_id_, msg.id_,'تم ارسل على وقت \n '..(60 - timemkall)..' ثواني')
end
redis:del(bot_id.."makal:bots:qus"..msg.sender_user_id_..":"..msg.chat_id_)
redis:del(bot_id.."mkal:setex:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if text and text:match("تغيير (.*)") and msg.reply_to_message_id_ ~= 0 and Constructor(msg)then
local namess = text:match("تغيير (.*)")
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlIl3')..') '
status  = '\n• الايدي ⇠ '..result.sender_user_id_..' \n تم تغيير لقب '..namess..''
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_.."&custom_title="..namess)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^(تغيير) @(.*) (.*)$") then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( منشئ - منشئ اساسي - Commander )')
return false
end
local TextEnd = {string.match(text, "^(تغيير) @(.*) (.*)$")}
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlIl3')..')'
status  = ' \n تم تغيير لقب '..TextEnd[3]..' '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id="..result.id_.."&custom_title="..TextEnd[3])
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[2]}, start_function, nil)
return false
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( منشئ - منشئ اساسي - Commander )')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlIl3')..') '
status  = '\n• الايدي ⇠ '..result.sender_user_id_..' \n تم رفعه مشرف بالقروب '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( منشئ - منشئ اساسي - Commander )')
return false
end
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlIl3')..')'
status  = '\n تم رفعه مشرف بالقروب '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( منشئ - منشئ اساسي - Commander )')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlIl3')..') '
status  = '\n• الايدي ⇠ '..result.sender_user_id_..' \n تم تنزيله ادمن من القروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") then
if not Constructor(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( منشئ - منشئ اساسي - Commander )')
return false
end
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlIl3')..')'
status  = '\n تم تنزيله مشرف من القروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع مالك") and msg.reply_to_message_id_ ~= 0 then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlIl3')..') '
status  = '\n• الايدي ⇠ '..result.sender_user_id_..' \n تم رفع العضو مالك القروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^مالك @(.*)$") then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
local username = text:match("^مالك @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlIl3')..')'
status  = '\n تم رفع العضو مالك'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ ~= 0 then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n• العضو ⇠ ['..data.first_name_..'](t.me/'..(data.username_ or 'hlIl3')..') '
status  = '\n• الايدي ⇠ '..result.sender_user_id_..' \n تم تنزيله تنزيل مالك من القروب بكل الصلاحيات'
send1(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") then
if not PresidentGroup(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص بالمنشئ الاساسي فقط')
return false
end
local username = text:match("^تنزيل مالك @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,' البوت ليس مشرف يرجى ترقيتي ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه ")   
return false 
end      
usertext = '\n• العضو ⇠ ['..result.title_..'](t.me/'..(username or 'hlIl3')..')'
status  = '\n تم رفع عضو مالك'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( مدير - منشئ - منشئ اساسي)')
return false
end     
function cb(a,b,c) 
textt = '•تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
redis:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
redis:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
redis:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( مدير - منشئ - منشئ اساسي)')
return false
end     
function cb(a,b,c) 
textt = '• تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
redis:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
redis:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
redis:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'مسح قائمه منع المتحركات' then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( مدير - منشئ - منشئ اساسي)')
return false
end     
redis:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'• تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( مدير - منشئ - منشئ اساسي)')
return false
end     
redis:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'• تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' then
if not Owner(msg) then
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( مدير - منشئ - منشئ اساسي)')
return false
end     
redis:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'• تم مسح قائمه منع الملصقات')  
end

if text == 'تغيير الايدي' then
if not Admin(msg) then 
send(msg.chat_id_,msg.id_,'عذرا الامر يخص ( الادمن - مدير - منشئ )')
return false
end 
local List = {[[
𖡋 𝐔𝐒𝐄 ⌯ #username 𖥲 .
𖡋 𝐌𝐒𝐆 ⌯ #msgs 𖥲 .
𖡋 𝐒𝐓𝐀 ⌯ #stast 𖥲 .
𖡋 𝐈𝐃 ⌯ #id 𖥲 .
]],
[[
-›   𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 ¦ #username .
-›   𝙸𝙳 ¦ #msgs .
-›   𝚂𝚃𝙰𝚂𝚃 ¦ #stast .
-›   𝙼𝚂𝙶𝚂 ¦ #id .
]],
[[
𝐔𝐬𝐞𝐫  : #username  .
𝐌𝐬𝐠𝐞 :  #msgs  .
𝐒𝐭𝐚 :#stast  .
𝐈𝐝 : #id  .
]],
[[
𝗨𝗦𝗘𝗥??𝗔𝗠??: #username  .
𝗠𝗦𝗚: #msgs  .
𝗦𝗧𝗔𝗧 :#stast  .
𝗜𝗗: #id  .
]],
[[
𝗨𝗦𝗘𝗥????𝗠??: #username  .
𝗠𝗦𝗚: #msgs  .
𝗦𝗧𝗔𝗧 :#stast  .
𝗜𝗗: #id  .
]],
[[
𝚄𝚜𝚎𝚛 ✯ #username  
𝚂𝚝𝚊  ✯ #stast  
𝙸𝚍   ✯ #id  
𝙼𝚜𝚐𝚎 ✯ #msgs
]]}
local Text_Rand = List[math.random(#List)]
redis:set(bot_id.."FDFGERB:Set:Id:Group"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'܁تم تغيير الايدي ܊ قم بالتجربه ܊ ')
end
if text == 'تعيين الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:setex(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
܁يمكنك اضافة ܊
▹ `#username` - ܁ اسم المستخدم
▹ `#msgs` - ܁ عدد رسائل المستخدم
▹ `#photos` - ܁ عدد صور المستخدم
▹ `#id` - ܁ ايدي المستخدم
▹ `#stast` - ܁ رتبة المستخدم
▹ `#edit` - ܁ عدد تعديلات 
▹ `#game` - ܁ نقاط
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end
if redis:get(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"܁تم الغاء تعيين الايدي") 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
redis:del(bot_id.."CHENG:ID:bot"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
redis:set(bot_id.."KLISH:ID:bot",CHENGER_ID)
send(msg.chat_id_, msg.id_,'܁تم تعيين الايدي بنجاح')    
end
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:del(bot_id.."KLISH:ID:bot")
send(msg.chat_id_, msg.id_, '܁ تم ازالة كليشة الايدي ')
return false  
end 
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) == 0 and not redis:get(bot_id..'FDFGERB:Lock:Id:Photo'..msg.chat_id_) then
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,taha,success) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Ctitle = json:decode(https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_))
if Ctitle.result.status == "administrator" and Ctitle.result.custom_title or Ctitle.result.status == "creator" and Ctitle.result.custom_title then
lakbk = Ctitle.result.custom_title
else
lakbk = 'لا يوجد'
end
local Id = msg.sender_user_id_
local NumMsg = redis:get(bot_id..'FDFGERB:Num:Message:User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'FDFGERB:Num:Message:Edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Num_Games = redis:get(bot_id.."FDFGERB:Num:Add:Games"..msg.chat_id_..msg.sender_user_id_) or 0
local Add_Mem = redis:get(bot_id.."FDFGERB:Num:Add:Memp"..msg.chat_id_..":"..msg.sender_user_id_) or 0
local Total_Photp = (taha.total_count_ or 0)
local Texting = {
'ملاك وناسيك بكروبنه😟',
"حلغوم والله☹️ ",
"اطلق صوره🐼❤️",
"كيكك والله🥺",
"لازك بيها غيرها عاد😒",
}
local Description = Texting[math.random(#Texting)]
local Get_Is_Id = redis:get(bot_id.."KLISH:ID:bot") or redis:get(bot_id.."FDFGERB:Set:Id:Group"..msg.chat_id_)
if not redis:get(bot_id..'FDFGERB:Lock:Id:Py:Photo'..msg.chat_id_) then
if taha.photos_[0] then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
sendPhoto(msg.chat_id_,msg.id_,taha.photos_[0].sizes_[1].photo_.persistent_id_,Get_Is_Id)
else
sendPhoto(msg.chat_id_,msg.id_,taha.photos_[0].sizes_[1].photo_.persistent_id_,'• '..Description..'\n• ايديك ← '..Id..'\n• معرفك ← '..UserName_User..'\n• رتبتك ← '..Status_Gps..'\n• رسائلك ← '..NumMsg..'\n• السحكات ← '..NumMessageEdit..' \n• تتفاعلك ← '..TotalMsg..'\n• مجوهراتك ← '..Num_Games..'\n• لقبك ← '..lakbk)
end
else
send(msg.chat_id_, msg.id_,'\n• ايديك ← '..Id..'\n• معرفك ← ['..UserName_User..']\n• رتبتك ← '..Status_Gps..'\n• رسائلك ← '..NumMsg..'\n• السحكات ← '..NumMessageEdit..' \n• تتفاعلك ← '..TotalMsg..'\n•  مجوهراتك ← '..Num_Games..'\n• لقبك ← '..lakbk) 
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',Add_Mem) 
local Get_Is_Id = Get_Is_Id:gsub('#id',Id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserName_User) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',NumMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',NumMessageEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',Status_Gps) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',Num_Games) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',Total_Photp) 
send(msg.chat_id_, msg.id_,'['..Get_Is_Id..']') 
else
send(msg.chat_id_, msg.id_,'\n• ايديك ← '..Id..'\n• معرفك ← ['..UserName_User..']\n• رتبتك ← '..Status_Gps..'\n• رسائلك ← '..NumMsg..'\n• السحكات ← '..NumMessageEdit..' \n• تتفاعلك ← '..TotalMsg..'\n• مجوهراتك ← '..Num_Games..'\n• لقبك ← '..lakbk) 
end
end
end,nil)   
end,nil)   
end

if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id..'FDFGERB:Lock:Id:Photo'..msg.chat_id_) or text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 and not redis:get(bot_id..'FDFGERB:Lock:Id:Photo'..msg.chat_id_) then
function Function_Status(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.first_name_ == false then
send(msg.chat_id_, msg.id_,'• الحساب محذوف لا توجد معلوماته ')
return false
end
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsg = redis:get(bot_id..'FDFGERB:Num:Message:User'..msg.chat_id_..':'..data.id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'FDFGERB:Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."FDFGERB:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."FDFGERB:Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*• ايديه ← '..Id..'\n• رسائله ← '..NumMsg..'\n• معرفه ← *['..UserName_User..']*\n• تفاعله ← '..TotalMsg..'\n• رتبته ← '..Status_Gps..'\n• تعديلاته ← '..NumMessageEdit..'\n• جهاته ← '..Add_Mem..'*') 
end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_Status, nil)
return false
end
if text and text:match("^ايدي @(.*)$") and not redis:get(bot_id..'FDFGERB:Lock:Id:Photo'..msg.chat_id_) or text and text:match("^كشف @(.*)$") and not redis:get(bot_id..'FDFGERB:Lock:Id:Photo'..msg.chat_id_) then
local username = text:match("^ايدي @(.*)$") or text:match("^كشف @(.*)$")
function Function_Status(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data.username_ then
UserName_User = '@'..data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local NumMsg = redis:get(bot_id..'FDFGERB:Num:Message:User'..msg.chat_id_..':'..data.id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(Id,msg.chat_id_)
local NumMessageEdit = redis:get(bot_id..'FDFGERB:Num:Message:Edit'..msg.chat_id_..data.id_) or 0
local Num_Games = redis:get(bot_id.."FDFGERB:Msg_User"..msg.chat_id_..":"..data.id_) or 0
local Add_Mem = redis:get(bot_id.."FDFGERB:Num:Add:Memp"..msg.chat_id_..":"..data.id_) or 0
send(msg.chat_id_, msg.id_,'\n*• ايديه ← '..Id..'\n• رسائله ← '..NumMsg..'\n• معرفه ← *['..UserName_User..']*\n• تفاعله ← '..TotalMsg..'\n• رتبته ← '..Status_Gps..'\n• تعديلاته ← '..NumMessageEdit..'\n• جهاته ← '..Add_Mem..'*') 
end,nil)   
else
send(msg.chat_id_, msg.id_,'• لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_Status, nil)
return false
end

if text == 'تاك للكل' and Admin(msg) then
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""), offset_ = 0,limit_ = 400},function(ta,taha)
t = "\n• قائمة الاعضاء \n · · • • • ⍒ • • • · ·  \n"
local list = taha.members_
for i=0 ,#list do
tdcli_function ({ID = "GetUser",user_id_ = taha.members_[i].user_id_},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = taha.members_[i].user_id_
end
t = t..''..i..'- '..username..' \n '
if #list == i then
send(msg.chat_id_, msg.id_,t)
end
end,nil)
end
end,nil)
end

if text == 'تحويل ملصق' and tonumber(msg.reply_to_message_id_) > 0 then
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_ then
if data.content_.photo_.sizes_[0] then
photo_in_group = data.content_.photo_.sizes_[0].photo_.persistent_id_
end
if data.content_.photo_.sizes_[1] then
photo_in_group = data.content_.photo_.sizes_[1].photo_.persistent_id_
end
if data.content_.photo_.sizes_[2] then
photo_in_group = data.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if data.content_.photo_.sizes_[3] then
photo_in_group = data.content_.photo_.sizes_[3].photo_.persistent_id_
end
end
local File = json:decode(https.request('https://api.telegram.org/bot' .. token .. '/getfile?file_id='..photo_in_group) ) 
local Name_File = download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, './'..msg.id_..'.webp') 
sendSticker(msg.chat_id_,msg.id_,Name_File)
os.execute('rm -rf '..Name_File) 
else
send(msg.chat_id_,msg.id_,'هذه ليست صوره')
end
end, nil)
end
if text == 'صوره' and tonumber(msg.reply_to_message_id_) > 0 then
tdcli_function({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},function(arg,data)
if data.content_.ID == "MessageSticker" then    
local File = json:decode(https.request('https://api.telegram.org/bot' .. token .. '/getfile?file_id='..data.content_.sticker_.sticker_.persistent_id_) ) 
local Name_File = download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, './'..msg.id_..'.jpg') 
sendPhoto(msg.chat_id_,msg.id_,Name_File,'')
os.execute('rm -rf '..Name_File) 
else
send(msg.chat_id_,msg.id_,'هذا ليس ملصق')
end
end, nil)
end
if text == 'تغيير C' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
redis:set(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,' ارسل الان معرف Carbon الجديد')
return false
end
if text and redis:get(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_) then
if text == 'الغاء' then 
redis:del(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_)
send(msg.chat_id_, msg.id_,' تم الغاء تغيير Carbon')
return false
end
local username = text:gsub('@','')
tdcli_function ({ID = "SearchPublicChat",username_ = username}, function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"• عذرا عزيزي هذا معرف قناة يرجى ارسال المعرف مره اخره")   
return false 
end      
local file_Info_Sudo = io.open("Info_Sudo.lua", 'w')
file_Info_Sudo:write([[
do 
local File_Info = {
id_dev = "]]..result.id_..[[",
UserName_dev = "@]]..username..[[",
Token_Bot = "]]..token..[["
}
return File_Info
end
]])
file_Info_Sudo:close()
else
send(msg.chat_id_, msg.id_, '• لا يوجد حساب بهذا المعرف')
end
end, nil)
redis:del(bot_id..'Set:Text:Dev:Bot:id'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'تم تغيير Carbon \n الرجاء ارسل امر [تحديث]')
dofile('FDFGERB.lua')  
return false
end

if text == 'رفع نسخه الاحتياطيه' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'رفع المشتركين' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
local info_file = io.open('./users.json', "r"):read('*a')
local users = JSON.decode(info_file)
for k,v in pairs(users.users) do
redis:sadd(bot_id..'FDFGERB:Num:User:Pv',v) 
end
send(msg.chat_id_,msg.id_,'تم رفع :'..#users.users..' مشترك ')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
if text == 'جلب المشتركين' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
local list = redis:smembers(bot_id..'FDFGERB:Num:User:Pv') 
local t = '{"users":['  
for k,v in pairs(list) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end
t = t..']}'
local File = io.open('./users.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './users.json', 'عدد المشتركين :'..#list)
end

if text == 'جلب نسخه الاحتياطيه' then
if not Dev_Bots(msg) then
send(msg.chat_id_,msg.id_,' هذا الامر خاص Carbon فقط')
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر' then
send(msg.chat_id_,msg.id_,[[
جلب المشتركين
جلب نسخه احتياطيه
رفع المشتركين
رفع نسخه الاحتياطيه
صوره 
تحويل ملصق
تاك للكل
ايدي . كشف 
تعين الايدي عام
حذف الايدي عام
تغير الايدي
مسح قائمه منع الصور 
مسح قائمه منع المتحركه
مسح قائمه منع الملصقات 
منع / الغاء منع
رفع مالك
تنزيل مالك
رفع مشرف 
تنزيل مشرف 
تغيير
اضف سؤال مقالات
حذف سؤال مقالات
اضف سؤال كت تويت
حذف سؤال كت تويت
تفعيل /تعطيل الاشتراك
الاشتراك الاجباري
تغير الاشتراك
تعين عدد الاعضاء + الرقم
رفع المنشئ
رفع الادمنيه
المنشئ
كشف القيود 
رفع القيود
اطردني
تنظيف الكروبات
تنظيف المشتركين
اضف رسائل
اضف مجوهرات
رسائلي 
جهاتي
مجوهراتي
سحكاتي
امثله
المختلف
محيبس
خمن
العكس
معاني
حزوره
الاسرع
سمايلات
تعين الايدي
اذاعه بالتوجيه خاص
اذاعه بالتوجيه
اذاعه خاص 
اذاعه
وضع كليشه المطور
اضف صلاحيه
مسح صلاحيه
اضف امر
حذف امر
اضف رد عام
حذف رد عام
ردود المطور
مسح ردود المطور
حذف رد 
اضف رد
ردود المدير
مسح ردود المدير
مسح الصلاحيات
حذف الاوامر المضافه
الصلاحيات
الاوامر المضافه
الاعدادات
عدد الكروب
غادر 
رتبتي
اسمي
تنزيل الكل
كشف البوتات
مسح البوتات
مسح المحذوفين
تثبيت
الغاء تثبيت
منع /الغاء منع
قائمه المنع
مسح قائمه المنع
وضع : تكرار
مسح رسائلي ,جهاتي , سحكاتي
حذف الصوره
مسح الترحيب, القوانين
الرابط , الترحيب , القوانين ,
ضع :وصف ,ترخيب,رابط,قوانين
صورتي
ضافني
صيح
تعطيل / تفعيل : صورتي , الرابط , ضافني , اطردني ,صيح , ردود المدير , ردود المطور , الايدي, الابدي بالصوره , البوت الخدمي ,الرفع , الطرد , الالعاب, الاذاعه , المغادره  , الترحيب


]])
end
if text == 'اوامر الحمايه' and Admin(msg) then
local Texti = 'تستطيع قفل وفتح عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'قفل الاضافه', callback_data="/lockjoine"},{text = 'فتح الاضافه', callback_data="/unlockjoine"},
},
{
{text = 'قفل الدردشه', callback_data="/lockchat"},{text = 'فتح الدردشه', callback_data="/unlockchat"},
},
{
{text = 'قفل الدخول', callback_data="/lock_joine"},{text = 'فتح الدخول', callback_data="/unlock_joine"},
},
{
{text = 'قفل البوتات', callback_data="/lockbots"},{text = 'فتح البوتات', callback_data="/unlockbots"},
},
{
{text = 'قفل الاشعارات', callback_data="/locktags"},{text = 'فتح الاشعارات', callback_data="/unlocktags"},
},
{
{text = 'قفل التعديل', callback_data="/lockedit"},{text = 'فتح التعديل', callback_data="/unlockedit"},
},
{
{text = 'قفل الروابط', callback_data="/locklink"},{text = 'فتح الروابط', callback_data="/unlocklink"},
},
{
{text = 'قفل المعرفات', callback_data="/lockusername"},{text = 'فتح المعرفات', callback_data="/unlockusername"},
},
{
{text = 'قفل التاك', callback_data="/locktag"},{text = 'فتح التاك', callback_data="/unlocktag"},
},
{
{text = 'قفل الملصقات', callback_data="/locksticar"},{text = 'فتح الملصقات', callback_data="/unlocksticar"},
},
{
{text = 'قفل المتحركه', callback_data="/lockgif"},{text = 'فتح المتحركه', callback_data="/unlockgif"},
},
{
{text = 'قفل الفيديو', callback_data="/lockvideo"},{text = 'فتح الفيديو', callback_data="/unlockvideo"},
},
{
{text = 'قفل الصور', callback_data="/lockphoto"},{text = 'فتح الصور', callback_data="/unlockphoto"},
},
{
{text = 'قفل الاغاني', callback_data="/lockvoise"},{text = 'فتح الاغاني', callback_data="/unlockvoise"},
},
{
{text = 'قفل الصوت', callback_data="/lockaudo"},{text = 'فتح الصوت', callback_data="/unlockaudo"},
},
{
{text = 'قفل التوجيه', callback_data="/lockfwd"},{text = 'فتح التوجيه', callback_data="/unlockfwd"},
},
{
{text = 'قفل الملفات', callback_data="/lockfile"},{text = 'فتح الملفات', callback_data="/unlockfile"},
},
{
{text = 'قفل الجهات', callback_data="/lockphone"},{text = 'فتح الجهات', callback_data="/unlockphone"},
},
{
{text = 'قفل الكلايش', callback_data="/lockposts"},{text = 'فتح الكلايش', callback_data="/unlockposts"},
},
{
{text = 'قفل التكرار', callback_data="/lockflood"},{text = 'فتح التكرار', callback_data="/unlockflood"},
},
{
{text = 'قفل الفارسيه', callback_data="/lockfarse"},{text = 'فتح الفارسيه', callback_data="/unlockfarse"},
},
{
{text = 'قفل السب', callback_data="/lockfshar"},{text = 'فتح السب', callback_data="/unlockfshar"},
},
{
{text = 'قفل الانجليزيه', callback_data="/lockenglish"},{text = 'فتح الانجليزيه', callback_data="/unlockenglish"},
},
{
{text = 'قفل الانلاين', callback_data="/lockinlene"},{text = 'فتح الانلاين', callback_data="/unlockinlene"},
},

}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Texti).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'اوامر المجموعه' and Owner(msg) then
local Texti = 'تستطيع تعطيل وتفعيل عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعطيل التنزيل', callback_data="/lockdul"},{text = 'تفعيل التنزيل', callback_data="/unlockdul"},
},
{
{text = 'تعطيل الرابط', callback_data="/lock_links"},{text = 'تفعيل الرابط', callback_data="/unlock_links"},
},
{
{text = 'تعطيل صورتي', callback_data="/lockmyphoto"},{text = 'تفعيل صورتي', callback_data="/unlockmyphoto"},
},
{
{text = 'تعطيل الترحيب', callback_data="/lockwelcome"},{text = 'تفعيل الترحيب', callback_data="/unlockwelcome"},
},
{
{text = 'تعطيل الردود العامه', callback_data="/lockrepall"},{text = 'تفعيل الردود العامه', callback_data="/unlockrepall"},
},
{
{text = 'تعطيل الايدي', callback_data="/lockide"},{text = 'تفعيل الايدي', callback_data="/unlockide"},
},
{
{text = 'تعطيل الايدي بالصوره', callback_data="/lockidephoto"},{text = 'تفعيل الايدي بالصوره', callback_data="/unlockidephoto"},
},
{
{text = 'تعطيل الحظر', callback_data="/lockkiked"},{text = 'تفعيل الحظر', callback_data="/unlockkiked"},
},
{
{text = 'تعطيل الرفع', callback_data="/locksetm"},{text = 'تفعيل الرفع', callback_data="/unlocksetm"},
},
{
{text = 'تعطيل ضافني', callback_data="/lockaddme"},{text = 'تفعيل ضافني', callback_data="/unlockaddme"},
},
{
{text = 'تعطيل صيح', callback_data="/locksehe"},{text = 'تفعيل صيح', callback_data="/unlocksehe"},
},
{
{text = 'تعطيل اطردني', callback_data="/lockkikedme"},{text = 'تفعيل اطردني', callback_data="/unlockkikedme"},
},
{
{text = 'تعطيل الالعاب', callback_data="/lockgames"},{text = 'تفعيل الالعاب', callback_data="/unlockgames"},
},
{
{text = 'تعطيل الردود', callback_data="/lockrepgr"},{text = 'تفعيل الردود', callback_data="/unlockrepgr"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Texti).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'تنزيل الكل' and Owner(msg) then
redis:del(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_)
redis:del(bot_id.."FDFGERB:Vip:Group"..msg.chat_id_)
return send(msg.chat_id_, msg.id_, "•  تم مسح جميع رتب المجموعه")
end
if text == 'كشف المجموعه' and Owner(msg) then
local list1 = redis:smembers(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_)
local list2 = redis:smembers(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
local list3 = redis:smembers(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_)
local list4 = redis:smembers(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
if #list1 == 0 and #list2 == 0 and #list3 == 0 and #list4 == 0 then
return send(msg.chat_id_, msg.id_,'• لا يوجد رتب هنا')
end 
local list = redis:smembers(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
if #list ~= 0 then
vips = "\n• قائمة المميزين في المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
vips = vips..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, vips)
end
end,nil)
end
end
local list = redis:smembers(bot_id.."FDFGERB:Admin:Group"..msg.chat_id_)
if #list ~= 0 then
Admin = "\n• قائمة الادمنيه في المجموعه\n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Admin = Admin..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Admin)
end
end,nil)
end
end
local list = redis:smembers(bot_id.."FDFGERB:Manager:Group"..msg.chat_id_)
if #list ~= 0 then
mder = "\n• قائمة المدراء المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
mder = mder..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, mder)
end
end,nil)
end
end
local list = redis:smembers(bot_id.."FDFGERB:Constructor:Group"..msg.chat_id_)
if #list ~= 0 then
Monsh = "\n• قائمة منشئين المجموعه \n━━━━━━━━━━━━━\n"
for k,v in pairs(list) do
tdcli_function ({ID = "GetUser",user_id_ = v},function(arg,data) 
if data.username_ then
username = '[@'..data.username_..']'
else
username = v 
end
Monsh = Monsh..""..k.."~ : "..username.."\n"
if #list == k then
return send(msg.chat_id_, msg.id_, Monsh)
end
end,nil)
end
end
end
if text == 'الاوامر' or text == 'اوامر' or text == 'الأوامر' then
if Admin(msg) then
local Text =[[
help
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data="/help1"},{text = '⓶', callback_data="/help2"},{text = '⓷', callback_data="/help3"},
},
{
{text = '⓸', callback_data="/help4"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end


end
end
end
------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)
if data.ID == ("UpdateChannel") then 
if data.channel_.status_.ID == ("ChatMemberStatusKicked") then 
redis:srem(bot_id..'FDFGERB:ChekBotAdd','-100'..data.channel_.id_)  
end
elseif data.ID == ("UpdateNewMessage") then
msg = data.message_
text = msg.content_.text_
if msg.date_ and msg.date_ < tonumber(os.time() - 30) then
print("->> Old Message End <<-")
return false
end
------------------------------------------------------------------------------------------------------------
if tonumber(msg.sender_user_id_) ~= tonumber(bot_id) then  
if msg.sender_user_id_ and RemovalUserGroup(msg.chat_id_,msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false  
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroup(msg.chat_id_,msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false
elseif msg.sender_user_id_ and RemovalUserGroups(msg.sender_user_id_) then 
KickGroup(msg.chat_id_,msg.sender_user_id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false 
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and RemovalUserGroups(msg.content_.members_[0].id_) then 
KickGroup(msg.chat_id_,msg.content_.members_[0].id_) 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
elseif msg.sender_user_id_ and SilencelUserGroups(msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_}) 
return false 
elseif msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and SilencelUserGroups(msg.content_.members_[0].id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
elseif msg.sender_user_id_ and MutedGroups(msg.chat_id_,msg.sender_user_id_) then 
Delete_Message(msg.chat_id_, {[0] = msg.id_})  
return false  
end
end
if text and redis:get(bot_id.."FDFGERB:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = redis:get(bot_id.."FDFGERB:Get:Reides:Commands:Group"..msg.chat_id_..":"..text)
if NewCmmd then
redis:del(bot_id.."FDFGERB:Get:Reides:Commands:Group"..msg.chat_id_..":"..text)
redis:del(bot_id.."FDFGERB:Command:Reids:Group:New"..msg.chat_id_)
redis:srem(bot_id.."FDFGERB:Command:List:Group"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,"• تم ازالة هاذا ← { "..text.." }")  
else
send(msg.chat_id_, msg.id_,"• لا يوجد امر بهاذا الاسم")  
end
redis:del(bot_id.."FDFGERB:Command:Reids:Group:Del"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if text then
local NewCmmd = redis:get(bot_id.."FDFGERB:Get:Reides:Commands:Group"..msg.chat_id_..":"..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == "MessagePinMessage" or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == "MessageChatChangeTitle" or msg.content_.ID == "MessageChatDeleteMember" then   
if redis:get(bot_id.."FDFGERB:Lock:tagservr"..msg.chat_id_) then  
Delete_Message(msg.chat_id_,{[0] = msg.id_})       
return false
end    
elseif text and not redis:sismember(bot_id..'FDFGERB:Spam_For_Bot'..msg.sender_user_id_,text) then
redis:del(bot_id..'FDFGERB:Spam_For_Bot'..msg.sender_user_id_) 
elseif msg.content_.ID == "MessageChatAddMembers" then  
redis:set(bot_id.."FDFGERB:Who:Added:Me"..msg.chat_id_..":"..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
elseif msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = redis:get(bot_id.."FDFGERB:Lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Admin(msg) and Bots == "del" then   
Get_Info = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(Get_Info)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_Admin(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
TypeForChat1 = 'ForSuppur' 
elseif id:match("^(%d+)") then
TypeForChat1 = 'ForUser' 
else
TypeForChat1 = 'ForGroup' 
end
end
if text == 'تفعيل' and DeveloperBot(msg) then
if TypeForChat1 ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'• المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'• البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'FDFGERB:Num:Add:Bot') or 0) and not Dev_Bots(msg) then
send(msg.chat_id_, msg.id_,'• لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'FDFGERB:Num:Add:Bot') or 0)..'* عضو')
return false
end
if redis:sismember(bot_id..'FDFGERB:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'• تم تفعيل المجموعه مسبقا')
else
local Texti = 'عليك اختيار نوع المجموعه لتفعيلها'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'وضع النشر', callback_data="/addsender@"..msg.sender_user_id_},{text = 'وضع الدردشه', callback_data="/addchat@"..msg.sender_user_id_},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Texti).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end,nil)
end
if text == 'تفعيل' and not DeveloperBot(msg) then
if TypeForChat1 ~= 'ForSuppur' then
send(msg.chat_id_, msg.id_,'• المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي') 
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'• البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(redis:get(bot_id..'FDFGERB:Num:Add:Bot') or 0) and not Dev_Bots(msg) then
send(msg.chat_id_, msg.id_,'• لا تستطيع تفعيل المجموعه بسبب قلة عدد اعضاء المجموعه يجب ان يكون اكثر من *:'..(redis:get(bot_id..'FDFGERB:Num:Add:Bot') or 0)..'* عضو')
return false
end
if redis:sismember(bot_id..'FDFGERB:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'• تم تفعيل المجموعه مسبقا')
else
local Texti = 'عليك اختيار نوع المجموعه لتفعيلها'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'وضع النشر', callback_data="/addsender@"..msg.sender_user_id_},{text = 'وضع الدردشه', callback_data="/addchat@"..msg.sender_user_id_},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Texti).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end,nil)
end
------------------------------------------------------------------------------------------------------------
if text == 'تعطيل' and DeveloperBot(msg) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not redis:sismember(bot_id..'FDFGERB:ChekBotAdd',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'• المجموعه بالتاكيد معطله')
else
Send_Options(msg,result.id_,'reply_Add','• تم تعطيل مجموعه '..chat.title_..'')
redis:srem(bot_id..'FDFGERB:ChekBotAdd',msg.chat_id_)  
redis:del(bot_id..'FDFGERB:ChekBot:Add'..msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_Bots(msg) then
sendText(Id_Dev,'• تم تعطيل مجموعه جديده\n'..'\n• بواسطة : '..Name..''..'\n• ايدي المجموعه : `'..IdChat..'`\n• اسم المجموعه : ['..NameChat..']',0,'md')
end
end
end,nil) 
end,nil) 
end
------------------------------------------------------------------------------------------------------------

if redis:get(bot_id..'FDFGERB:ChekBot:Add'..msg.chat_id_) == 'addsender' then
if msg.content_.text_ or msg.forward_info_ or msg.content_.ID == "MessageVoice" or msg.content_.ID == "MessageAudio" or msg.content_.ID == "MessageVideo" then
else
print('نشر')
Delete_Message(msg.chat_id_,{[0] = msg.id_})
end
else
Dev_Bots_File(msg,data)
end
elseif data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text and Text:match('/addsender@(.*)') then
if tonumber(Text:match('/addsender@(.*)')) == tonumber(data.sender_user_id_) then
local texten = '• تم تفعيل مجموعه '
https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(texten)..'&message_id='..msg_idd) 
redis:sadd(bot_id..'FDFGERB:ChekBotAdd',Chat_id)
redis:set(bot_id..'FDFGERB:ChekBot:Add'..Chat_id,'addsender')
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=Chat_id},function(arg,chat)  
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local IdChat = Chat_id
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..Chat_id))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_Bots(data) then
sendText(Id_Dev,'• تم تفعيل مجموعه جديده\n'..'\n• بواسطة : '..Name..''..'\n• ايدي المجموعه : `'..IdChat..'`'..'\n• اسم المجموعه : ['..NameChat..']'..'\n• الرابط : ['..LinkGp..']',0,'md')
end
end,nil) 
end,nil)
end
elseif Text and Text:match('/addchat@(.*)') then
print(Text:match('/addchat@(.*)'),data.sender_user_id_)
if tonumber(Text:match('/addchat@(.*)')) == tonumber(data.sender_user_id_) then
local texten = '• تم تفعيل مجموعه '
https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(texten)..'&message_id='..msg_idd) 
redis:sadd(bot_id..'FDFGERB:ChekBotAdd',Chat_id)
redis:del(bot_id..'FDFGERB:ChekBot:Add'..Chat_id)
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=Chat_id},function(arg,chat)  
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local IdChat = Chat_id
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..Chat_id))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
if not Dev_Bots(data) then
sendText(Id_Dev,'• تم تفعيل مجموعه جديده\n'..'\n• بواسطة : '..Name..''..'\n• ايدي المجموعه : `'..IdChat..'`'..'\n• اسم المجموعه : ['..NameChat..']'..'\n• الرابط : ['..LinkGp..']',0,'md')
end
end,nil) 
end,nil) 
end
end
if Text == '/help1' then
if not Mod(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
 help1
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data="/help1"},{text = '⓶', callback_data="/help2"},{text = '⓷', callback_data="/help3"},
},
{
{text = '⓸', callback_data="/help4"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help2' then
if not Mod(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
help2
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data="/help1"},{text = '⓶', callback_data="/help2"},{text = '⓷', callback_data="/help3"},
},
{
{text = '⓸', callback_data="/help4"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
if not Mod(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
help3
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data="/help1"},{text = '⓶', callback_data="/help2"},{text = '⓷', callback_data="/help3"},
},
{
{text = '⓸', callback_data="/help4"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
if not Mod(data) then
send(Chat_id, Msg_id,'') 
return false
end
local Teext =[[
help4
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data="/help1"},{text = '⓶', callback_data="/help2"},{text = '⓷', callback_data="/help3"},
},
{
{text = '⓸', callback_data="/help4"},
},
{
{text = 'الاوامر الرئيسيه', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help' then
if Mod(data) then
local Teext =[[
help
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⓵', callback_data="/help1"},{text = '⓶', callback_data="/help2"},{text = '⓷', callback_data="/help3"},
},
{
{text = '⓸', callback_data="/help4"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end

if Text == '/lockdul' and Owner(data) then
local Textedit = '• تم تعطيل التنزيل '
redis:set(bot_id..'dw:bot:api'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lock_links' and Owner(data) then
local Textedit = '• تم تعطيل الرابط '
redis:del(bot_id..'FDFGERB:Link_Group'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockmyphoto' and Owner(data) then
local Textedit = '• تم تعطيل صورتي '
redis:set(bot_id..'my_photo:status:bot'..Chat_id,'taha')
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockwelcome' and Owner(data) then
local Textedit = '• تم تعطيل الترحيب '
redis:del(bot_id..'FDFGERB:Chek:Welcome'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockrepall' and Owner(data) then
local Textedit = '• تم تعطيل الردود العامه '
redis:set(bot_id..'FDFGERB:Reply:Sudo'..Chat_id,true)   
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockide' and Owner(data) then
local Textedit = '• تم تعطيل الايدي '
redis:set(bot_id..'FDFGERB:Lock:Id:Photo'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockidephoto' and Owner(data) then
local Textedit = '• تم تعطيل الايدي بالصوره '
redis:set(bot_id..'FDFGERB:Lock:Id:Py:Photo'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockkiked' and Owner(data) then
local Textedit = '• تم تعطيل الحظر '
redis:set(bot_id..'FDFGERB:Lock:Ban:Group'..Chat_id,'true')
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/locksetm' and Owner(data) then
local Textedit = '• تم تعطيل الرفع '
redis:set(bot_id..'FDFGERB:Cheking:Seted'..Chat_id,'true')
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockaddme' and Owner(data) then
local Textedit = '• تم تعطيل ضافني '
redis:del(bot_id..'Added:Me'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/locksehe' and Owner(data) then
local Textedit = '• تم تعطيل صيح '
redis:del(bot_id..'Seh:User'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockkikedme' and Owner(data) then
local Textedit = '• تم تعطيل اطردني '
redis:set(bot_id..'FDFGERB:Cheking:Kick:Me:Group'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockgames' and Owner(data) then
local Textedit = '• تم تعطيل الالعاب '
redis:del(bot_id..'FDFGERB:Lock:Game:Group'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockrepgr' and Owner(data) then
local Textedit = '• تم تعطيل الردود '
redis:set(bot_id..'FDFGERB:Reply:Manager'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/unlockdul' and Owner(data) then
local Textedit = '• تم تفعيل التنزيل '
redis:del(bot_id..'dw:bot:api'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlock_links' and Owner(data) then
local Textedit = '• تم تفعيل الرابط '
redis:set(bot_id..'FDFGERB:Link_Group'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockmyphoto' and Owner(data) then
local Textedit = '• تم تفعيل صورتي '
redis:del(bot_id..'my_photo:status:bot'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockwelcome' and Owner(data) then
local Textedit = '• تم تفعيل الترحيب '
redis:set(bot_id..'FDFGERB:Chek:Welcome'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockrepall' and Owner(data) then
local Textedit = '• تم تفعيل الردود العامه '
redis:del(bot_id..'FDFGERB:Reply:Sudo'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockide' and Owner(data) then
local Textedit = '• تم تفعيل الايدي '
redis:del(bot_id..'FDFGERB:Lock:Id:Photo'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockidephoto' and Owner(data) then
local Textedit = '• تم تفعيل الايدي بالصوره '
redis:del(bot_id..'FDFGERB:Lock:Id:Py:Photo'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockkiked' and Owner(data) then
local Textedit = '• تم تفعيل الحظر '
redis:del(bot_id..'FDFGERB:Lock:Ban:Group'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlocksetm' and Owner(data) then
local Textedit = '• تم تفعيل الرفع '
redis:del(bot_id..'FDFGERB:Cheking:Seted'..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockaddme' and Owner(data) then
local Textedit = '• تم تفعيل ضافني '
redis:set(bot_id..'Added:Me'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlocksehe' and Owner(data) then
local Textedit = '• تم تفعيل صيح '
redis:set(bot_id..'Seh:User'..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockkikedme' and Owner(data) then
local Textedit = '• تم تفعيل اطردني '
redis:del(bot_id..'FDFGERB:Cheking:Kick:Me:Group'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockgames' and Owner(data) then
local Textedit = '• تم تفعيل الالعاب '
redis:set(bot_id..'FDFGERB:Lock:Game:Group'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockrepgr' and Owner(data) then
local Textedit = '• تم تفعيل الردود '
redis:del(bot_id..'FDFGERB:Reply:Manager'..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homeaddrem"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/homeaddrem' and Owner(data) then
local Texti = 'تستطيع تعطيل وتفعيل عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'تعطيل التنزيل', callback_data="/lockdul"},{text = 'تفعيل التنزيل', callback_data="/unlockdul"},
},
{
{text = 'تعطيل الرابط', callback_data="/lock_links"},{text = 'تفعيل الرابط', callback_data="/unlock_links"},
},
{
{text = 'تعطيل صورتي', callback_data="/lockmyphoto"},{text = 'تفعيل صورتي', callback_data="/unlockmyphoto"},
},
{
{text = 'تعطيل الترحيب', callback_data="/lockwelcome"},{text = 'تفعيل الترحيب', callback_data="/unlockwelcome"},
},
{
{text = 'تعطيل الردود العامه', callback_data="/lockrepall"},{text = 'تفعيل الردود العامه', callback_data="/unlockrepall"},
},
{
{text = 'تعطيل الايدي', callback_data="/lockide"},{text = 'تفعيل الايدي', callback_data="/unlockide"},
},
{
{text = 'تعطيل الايدي بالصوره', callback_data="/lockidephoto"},{text = 'تفعيل الايدي بالصوره', callback_data="/unlockidephoto"},
},
{
{text = 'تعطيل الحظر', callback_data="/lockkiked"},{text = 'تفعيل الحظر', callback_data="/unlockkiked"},
},
{
{text = 'تعطيل الرفع', callback_data="/locksetm"},{text = 'تفعيل الرفع', callback_data="/unlocksetm"},
},
{
{text = 'تعطيل ضافني', callback_data="/lockaddme"},{text = 'تفعيل ضافني', callback_data="/unlockaddme"},
},
{
{text = 'تعطيل صيح', callback_data="/locksehe"},{text = 'تفعيل صيح', callback_data="/unlocksehe"},
},
{
{text = 'تعطيل اطردني', callback_data="/lockkikedme"},{text = 'تفعيل اطردني', callback_data="/unlockkikedme"},
},
{
{text = 'تعطيل الالعاب', callback_data="/lockgames"},{text = 'تفعيل الالعاب', callback_data="/unlockgames"},
},
{
{text = 'تعطيل الردود', callback_data="/lockrepgr"},{text = 'تفعيل الردود', callback_data="/unlockrepgr"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Texti)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/lockjoine' and Admin(data) then
local Textedit = '• تم قفل الاضافه '
redis:set(bot_id.."FDFGERB:Lock:AddMempar"..Chat_id,"kick")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockchat' and Admin(data) then
local Textedit = '• تم قفل الدردشه '
redis:set(bot_id.."FDFGERB:Lock:text"..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lock_joine' and Admin(data) then
local Textedit = '• تم قفل الدخول '
redis:set(bot_id.."FDFGERB:Lock:Join"..Chat_id,"kick")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockbots' and Admin(data) then
local Textedit = '• تم قفل البوتات '
redis:set(bot_id.."FDFGERB:Lock:Bot:kick"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/locktags' and Admin(data) then
local Textedit = '• تم قفل الاشعارات '
redis:set(bot_id.."FDFGERB:Lock:tagservr"..Chat_id,true)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockedit' and Admin(data) then
local Textedit = '• تم قفل التعديل '
redis:set(bot_id.."FDFGERB:Lock:edit"..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/locklink' and Admin(data) then
local Textedit = '• تم قفل الروابط '
redis:set(bot_id.."FDFGERB:Lock:Link"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockusername' and Admin(data) then
local Textedit = '• تم قفل المعرفات '
redis:set(bot_id.."FDFGERB:Lock:User:Name"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/locktag' and Admin(data) then
local Textedit = '• تم قفل التاك '
redis:set(bot_id.."FDFGERB:Lock:hashtak"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/locksticar' and Admin(data) then
local Textedit = '• تم قفل الملصقات '
database:set(bot_id.."FDFGERB:Lock:Sticker"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockgif' and Admin(data) then
local Textedit = '• تم قفل المتحركات '
database:set(bot_id.."FDFGERB:Lock:Animation"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockvideo' and Admin(data) then
local Textedit = '• تم قفل الفيديو '
database:set(bot_id.."FDFGERB:Lock:Video"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockphoto' and Admin(data) then
local Textedit = '• تم قفل الصور '
database:set(bot_id.."FDFGERB:Lock:Photo"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockvoise' and Admin(data) then
local Textedit = '• تم قفل الاغاني '
database:set(bot_id.."FDFGERB:Lock:Audio"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockaudo' and Admin(data) then
local Textedit = '• تم قفل الصوت '
database:set(bot_id.."FDFGERB:Lock:vico"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockfwd' and Admin(data) then
local Textedit = '• تم قفل التوجيه '
database:set(bot_id.."FDFGERB:Lock:forward"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockfile' and Admin(data) then
local Textedit = '• تم قفل الملفات '
database:set(bot_id.."FDFGERB:Lock:Document"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockphone' and Admin(data) then
local Textedit = '• تم قفل الجهات '
database:set(bot_id.."FDFGERB:Lock:Contact"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockposts' and Admin(data) then
local Textedit = '• تم قفل الكلايش '
database:set(bot_id.."FDFGERB:Lock:Spam"..Chat_id,'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockflood' and Admin(data) then
local Textedit = '• تم قفل التكرار '
database:hset(bot_id.."FDFGERB:Spam:Group:User"..Chat_id ,"Spam:User",'del')  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockfarse' and Admin(data) then
local Textedit = '• تم قفل الفارسيه '
database:set(bot_id..'lock:Fars'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockfshar' and Admin(data) then
local Textedit = '• تم قفل السب '
database:set(bot_id..'lock:Fshar'..Chat_id,true) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockenglish' and Admin(data) then
local Textedit = '• تم قفل الانجليزيه '
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/lockinlene' and Admin(data) then
local Textedit = '• تم قفل الانلاين '
redis:set(bot_id.."FDFGERB:Lock:Inlen"..Chat_id,"del")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/unlockjoine' and Admin(data) then
local Textedit = '• تم فتح الاضافه '
redis:del(bot_id.."FDFGERB:Lock:AddMempar"..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockchat' and Admin(data) then
local Textedit = '• تم فتح الدردشه '
redis:del(bot_id.."FDFGERB:Lock:text"..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlock_joine' and Admin(data) then
local Textedit = '• تم فتح الدخول '
redis:del(bot_id.."FDFGERB:Lock:Join"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockbots' and Admin(data) then
local Textedit = '• تم فتح البوتات '
redis:del(bot_id.."FDFGERB:Lock:Bot:kick"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlocktags' and Admin(data) then
local Textedit = '• تم فتح الاشعارات '
redis:del(bot_id.."FDFGERB:Lock:tagservr"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockedit' and Admin(data) then
local Textedit = '• تم فتح التعديل '
redis:del(bot_id.."FDFGERB:Lock:edit"..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlocklink' and Admin(data) then
local Textedit = '• تم فتح الروابط '
redis:del(bot_id.."FDFGERB:Lock:Link"..Chat_id)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockusername' and Admin(data) then
local Textedit = '• تم فتح المعرفات '
redis:del(bot_id.."FDFGERB:Lock:User:Name"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlocktag' and Admin(data) then
local Textedit = '• تم فتح التاك '
redis:del(bot_id.."FDFGERB:Lock:hashtak"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlocksticar' and Admin(data) then
local Textedit = '• تم فتح الملصقات '
redis:del(bot_id.."FDFGERB:Lock:Sticker"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockgif' and Admin(data) then
local Textedit = '• تم فتح المتحركات '
redis:del(bot_id.."FDFGERB:Lock:Animation"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockvideo' and Admin(data) then
local Textedit = '• تم فتح الفيديو '
redis:del(bot_id.."FDFGERB:Lock:Video"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockphoto' and Admin(data) then
local Textedit = '• تم فتح الصور '
redis:del(bot_id.."FDFGERB:Lock:Photo"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockvoise' and Admin(data) then
local Textedit = '• تم فتح الاغاني '
redis:del(bot_id.."FDFGERB:Lock:Audio"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockaudo' and Admin(data) then
local Textedit = '• تم فتح الصوت '
redis:del(bot_id.."FDFGERB:Lock:vico"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockfwd' and Admin(data) then
local Textedit = '• تم فتح التوجيه '
redis:del(bot_id.."FDFGERB:Lock:forward"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockfile' and Admin(data) then
local Textedit = '• تم فتح الملفات '
redis:del(bot_id.."FDFGERB:Lock:Document"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockphone' and Admin(data) then
local Textedit = '• تم فتح الجهات '
redis:del(bot_id.."FDFGERB:Lock:Contact"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockposts' and Admin(data) then
local Textedit = '• تم فتح الكلايش '
redis:del(bot_id.."FDFGERB:Lock:Spam"..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockflood' and Admin(data) then
local Textedit = '• تم فتح التكرار '
redis:hdel(bot_id.."FDFGERB:Spam:Group:User"..Chat_id ,"Spam:User")  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockfarse' and Admin(data) then
local Textedit = '• تم فتح الفارسيه '
database:del(bot_id..'lock:Fars'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockfshar' and Admin(data) then
local Textedit = '• تم فتح السب '
database:del(bot_id..'lock:Fshar'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockenglish' and Admin(data) then
local Textedit = '• تم فتح الانجليزيه '
database:del(bot_id..'lock:Fars'..Chat_id) 
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/unlockinlene' and Admin(data) then
local Textedit = '• تم فتح الانلاين '
redis:del(bot_id.."FDFGERB:Lock:Inlen"..Chat_id)  
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'القائمه الرئيسيه', callback_data="/homelocks"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
elseif Text == '/homelocks' and Admin(data) then
local Texti = 'تستطيع قفل وفتح عبر الازرار'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'قفل الاضافه', callback_data="/lockjoine"},{text = 'فتح الاضافه', callback_data="/unlockjoine"},
},
{
{text = 'قفل الدردشه', callback_data="/lockchat"},{text = 'فتح الدردشه', callback_data="/unlockchat"},
},
{
{text = 'قفل الدخول', callback_data="/lock_joine"},{text = 'فتح الدخول', callback_data="/unlock_joine"},
},
{
{text = 'قفل البوتات', callback_data="/lockbots"},{text = 'فتح البوتات', callback_data="/unlockbots"},
},
{
{text = 'قفل الاشعارات', callback_data="/locktags"},{text = 'فتح الاشعارات', callback_data="/unlocktags"},
},
{
{text = 'قفل التعديل', callback_data="/lockedit"},{text = 'فتح التعديل', callback_data="/unlockedit"},
},
{
{text = 'قفل الروابط', callback_data="/locklink"},{text = 'فتح الروابط', callback_data="/unlocklink"},
},
{
{text = 'قفل المعرفات', callback_data="/lockusername"},{text = 'فتح المعرفات', callback_data="/unlockusername"},
},
{
{text = 'قفل التاك', callback_data="/locktag"},{text = 'فتح التاك', callback_data="/unlocktag"},
},
{
{text = 'قفل الملصقات', callback_data="/locksticar"},{text = 'فتح الملصقات', callback_data="/unlocksticar"},
},
{
{text = 'قفل المتحركه', callback_data="/lockgif"},{text = 'فتح المتحركه', callback_data="/unlockgif"},
},
{
{text = 'قفل الفيديو', callback_data="/lockvideo"},{text = 'فتح الفيديو', callback_data="/unlockvideo"},
},
{
{text = 'قفل الصور', callback_data="/lockphoto"},{text = 'فتح الصور', callback_data="/unlockphoto"},
},
{
{text = 'قفل الاغاني', callback_data="/lockvoise"},{text = 'فتح الاغاني', callback_data="/unlockvoise"},
},
{
{text = 'قفل الصوت', callback_data="/lockaudo"},{text = 'فتح الصوت', callback_data="/unlockaudo"},
},
{
{text = 'قفل التوجيه', callback_data="/lockfwd"},{text = 'فتح التوجيه', callback_data="/unlockfwd"},
},
{
{text = 'قفل الملفات', callback_data="/lockfile"},{text = 'فتح الملفات', callback_data="/unlockfile"},
},
{
{text = 'قفل الجهات', callback_data="/lockphone"},{text = 'فتح الجهات', callback_data="/unlockphone"},
},
{
{text = 'قفل الكلايش', callback_data="/lockposts"},{text = 'فتح الكلايش', callback_data="/unlockposts"},
},
{
{text = 'قفل التكرار', callback_data="/lockflood"},{text = 'فتح التكرار', callback_data="/unlockflood"},
},
{
{text = 'قفل الفارسيه', callback_data="/lockfarse"},{text = 'فتح الفارسيه', callback_data="/unlockfarse"},
},
{
{text = 'قفل السب', callback_data="/lockfshar"},{text = 'فتح السب', callback_data="/unlockfshar"},
},
{
{text = 'قفل الانجليزيه', callback_data="/lockenglish"},{text = 'فتح الانجليزيه', callback_data="/unlockenglish"},
},
{
{text = 'قفل الانلاين', callback_data="/lockinlene"},{text = 'فتح الانلاين', callback_data="/unlockinlene"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Texti)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end

elseif data.ID == ("UpdateMessageEdited") then
tdcli_function ({ID = "GetMessage",chat_id_ = data.chat_id_,message_id_ = tonumber(data.message_id_)},function(extra, result, success)
local textedit = result.content_.text_
redis:incr(bot_id..'FDFGERB:Num:Message:Edit'..result.chat_id_..result.sender_user_id_)
if redis:get(bot_id.."FDFGERB:Lock:edit"..msg.chat_id_) and not textedit and not PresidentGroup(result) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
Send_Options(result,result.sender_user_id_,"reply","• قام بالتعديل على الميديا")  
end
if not Vips(result) then
------------------------------------------------------------------------
if textedit and textedit:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt].[Mm][Ee]") or textedit and textedit:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("[hH][tT][tT][pP][sT]") or textedit and textedit:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or textedit and textedit:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if redis:get(bot_id.."FDFGERB:Lock:Link"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(@)(.*)") then
if redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("@") then
if redis:get(bot_id.."FDFGERB:Lock:User:Name"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("(.*)(#)(.*)") then
if redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("#") then
if redis:get(bot_id.."FDFGERB:Lock:hashtak"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end  
elseif textedit and textedit:match("/") then
if redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit and textedit:match("(.*)(/)(.*)") then
if redis:get(bot_id.."FDFGERB:Lock:Cmd"..msg.chat_id_) then
Delete_Message(result.chat_id_,{[0] = data.message_id_}) 
return false
end 
elseif textedit then
local Text_Filter = redis:get(bot_id.."FDFGERB:Filter:Reply2"..textedit..result.chat_id_)   
if Text_Filter then    
Delete_Message(result.chat_id_, {[0] = data.message_id_})     
Send_Options(result,result.sender_user_id_,"reply","• "..Text_Filter)  
return false
end
end
end
end,nil)
elseif data.ID == ("UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = redis:get(bot_id..'FDFGERB:Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;redis:del(bot_id..'FDFGERB:Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'FDFGERB:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'FDFGERB:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) redis:del(bot_id..'FDFGERB:Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end
elseif data.ID == ("UpdateOption") and data.value_.value_ == ("Ready") then
local list = redis:smembers(bot_id..'FDFGERB:Num:User:Pv')  
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end 
local list = redis:smembers(bot_id..'FDFGERB:ChekBotAdd') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
redis:srem(bot_id..'FDFGERB:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',v)  
end
if data and data.code_ and data.code_ == 400 then
redis:srem(bot_id..'FDFGERB:ChekBotAdd',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
redis:sadd(bot_id..'FDFGERB:ChekBotAdd',v)  
end 
end,nil)
end
end
end










