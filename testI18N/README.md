# I18NManager


I18NManager is used to change languages in app, Like Weibo, WeChat. But i really don't know how they do such a work, so i have to find my way to realize it.



## Usage
A demo to show the way how to change language in app and let it load string in corresponding localization string, and also save the language you set so that the app will load corresponding localization strings in the next launch.

Call the following function to set the app language as chinese-simple language.

	[I18NManager setAppLanguage:I18N_cn];
	
Then a notification ```kNotificationAppLanguageDidChange``` will be sent, you'd better to receive it, and in its selector, you should do some works to reload the localization string datas which you have already set in the previous language environment.

**For more details please check the codes.**

**If you have some more advices, please contact me, i'm great happy to communicate with you guys.**

The project should be opened with XCode5.


# License
The MIT License (MIT)

Copyright (c) 2013 Dick

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
