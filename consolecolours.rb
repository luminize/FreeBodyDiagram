class Consolecollours
#	//foreground color
#public static final String BLACK_TEXT()   { return "\033[30m";}
#public static final String RED_TEXT()     { return "\033[31m";}
#public static final String GREEN_TEXT()   { return "\033[32m";}
#public static final String BROWN_TEXT()   { return "\033[33m";}
#public static final String BLUE_TEXT()    { return "\033[34m";}
#public static final String MAGENTA_TEXT() { return "\033[35m";}
#public static final String CYAN_TEXT()    { return "\033[36m";}
#public static final String GRAY_TEXT()    { return "\033[37m";}

#//background color
#public static final String BLACK_BACK()   { return "\033[40m";}
#public static final String RED_BACK()     { return "\033[41m";}
#public static final String GREEN_BACK()   { return "\033[42m";}
#public static final String BROWN_BACK()   { return "\033[43m";}
#public static final String BLUE_BACK()    { return "\033[44m";}
#public static final String MAGENTA_BACK() { return "\033[45m";}
#public static final String CYAN_BACK()    { return "\033[46m";}
#public static final String WHITE_BACK()   { return "\033[47m";}

#//ANSI control chars
#public static final String RESET_COLORS() { return "\033[0m";}
#public static final String BOLD_ON()      { return "\033[1m";}
#public static final String BLINK_ON()     { return "\033[5m";}
#public static final String REVERSE_ON()   { return "\033[7m";}
#public static final String BOLD_OFF()     { return "\033[22m";}
#public static final String BLINK_OFF()    { return "\033[25m";}
#public static final String REVERSE_OFF()  { return "\033[27m";}

=begin
http://kpumuk.info/ruby-on-rails/colorizing-console-ruby-script-output/

Code	Effect
0	Turn off all attributes
1	Set bright mode
4	Set underline mode
5	Set blink mode
7	Exchange foreground and background colors
8	Hide text (foreground color would be the same as background)
30	Black text
31	Red text
32	Green text
33	Yellow text
34	Blue text
35	Magenta text
36	Cyan text
37	White text
39	Default text color
40	Black background
41	Red background
42	Green background
43	Yellow background
44	Blue background
45	Magenta background
46	Cyan background
47	White background
49	Default background color
=end

#http://en.wikipedia.org/wiki/ANSI_escape_code

end