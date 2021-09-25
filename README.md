# PSPasswordWolf
 Password Function using the Password Wolf API

The New-PasswordWolf Password Function was created using Invoke-RestMethod to access the https://passwordwolf.com API and parse the JSON to harvest the generated passwords.

I have included all of the options and pre-configured the parameter defaults, replicating the website settings.
"https://passwordwolf.com/api/?length=8&upper=on&lower=on&numbers=off&special=off&repeat=1"

|Variable|Values|Default|Description|
|---|---|---|---|
|upper|off/on| |Turns the upper case characters on or off.|
|lower|off/on| |Turns the lower case characters on or off.|
|numbers|off/on| |Turns numbers on or off.|
|special|off/on| |Turns special characters on or off.|
|length|1-128|15|Set the password length.|
|exclude|[string]|?!<>li1I08OB|Indicates which characters to exclude.|
|repeat|1-128|9|Indicates how many passwords to generate.|

More information can be found by visiting the PasswordWolf website - https://passwordwolf.com

Some time ago, I created a quick function using the PasswordWolf API (See below).

```powershell
function New-Password {
    $Alphas = Invoke-RestMethod -Uri "https://passwordwolf.com/api/?length=8&upper=on&lower=on&numbers=off&special=off&repeat=1"
    $Special = Invoke-RestMethod -Uri "https://passwordwolf.com/api/?length=1&upper=off&lower=off&numbers=off&special=on&exclude={}[]<>~¬&repeat=1"
    $Numbers = Invoke-RestMethod -Uri "https://passwordwolf.com/api/?length=3&upper=off&lower=off&numbers=on&special=off&repeat=1"
    
	
	$password = $Alphas.password + $Special.password + $Numbers.password
    $password

}
```
It was quick and dirty, so I decided to refactor the code and got a little bit carried away. I ended up creating two functions that provide both templated password formats and granular control over the formatting.

There are no doubt many other Password Modules available but there wasn't one using the Password Wolf API, so here is my effort.