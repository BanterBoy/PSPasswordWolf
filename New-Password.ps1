function New-Password {
    $Alphas = Invoke-RestMethod -Uri "https://passwordwolf.com/api/?length=8&upper=on&lower=on&numbers=off&special=off&repeat=1"
    $Special = Invoke-RestMethod -Uri "https://passwordwolf.com/api/?length=1&upper=off&lower=off&numbers=off&special=on&exclude={}[]<>~¬&repeat=1"
    $Numbers = Invoke-RestMethod -Uri "https://passwordwolf.com/api/?length=3&upper=off&lower=off&numbers=on&special=off&repeat=1"
    
	
	$password = $Alphas.password + $Special.password + $Numbers.password
    $password

}

<#
"https://passwordwolf.com/api/?length=8&upper=on&lower=on&numbers=off&special=off&repeat=1"

Variable	Possible Values		Default			Description
upper		off	on								Turns the upper case characters on or off.
lower		off	on								Turns the lower case characters on or off.
numbers		off	on								Turns numbers on or off.
special		off	on								Turns special characters on or off.
length		1-128				15				Set the password length.
exclude		[string]			?!<>li1I08OB`	Indicates which characters to exclude.
repeat		1-128				9				Indicates how many passwords to generate.
#>
