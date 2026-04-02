str1=['Video provides a powerful way to help you prove your point.' ...
    'When you click Online Video, you can paste in the embed code for the' ...
'video you want to add. You can also type a keyword to search online'...
    'for the video that and best fits your document.'];
    str2='and'
    strfind (str1, str2)
    
 % replace and with AND
 str3='AND'
 strrep (str2, str1, str3);

 
 return
 TF=0
 strsplit (str1)
 if TF =strcmp(str1,'and')
     disp TF('horray')
 end
 
 % also touch on printf & its arguements
 % \n new line
 % \t is tab
 % c character
 % d = integer
 % f = fixed poit notation
 %s = string
 
 % syntax = fprintf = see help
 

name = input('Please enter your name: ','s'); 
 
