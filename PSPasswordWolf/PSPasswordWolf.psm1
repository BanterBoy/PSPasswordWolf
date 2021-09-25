function New-PasswordWolf {

    <#
        .SYNOPSIS
        Password Function created using the https://passwordwolf.com API to generate passwords.
        All options and defaults on the site have been replicated within this function.

        .DESCRIPTION
        The New-PasswordWolf Password Function was created using Invoke-RestMethod to access the https://passwordwolf.com API and parse the JSON to harvest the generated passwords.

        I have included all of the options and pre-configured the parameter defaults, replicating the website settings.

        "https://passwordwolf.com/api/?length=8&upper=on&lower=on&numbers=off&special=off&repeat=1"

        Variable	Values      Default             Description
        upper	off/on                          Turns the upper case characters on or off.
        lower	off/on                          Turns the lower case characters on or off.
        numbers	off/on                          Turns numbers on or off.
        special	off/on                          Turns special characters on or off.
        length	1-128       15  	        Set the password length.
        exclude	[string]    ?!<>li1I08OB	Indicates which characters to exclude.
        repeat	1-128       9                   Indicates how many passwords to generate.

        More information can be found by visiting the PasswordWolf website - https://passwordwolf.com
        
        .EXAMPLE
        PS C:\> New-PasswordWolf -upper off -lower on -numbers on -special on -length 15 -repeat 5

        This Example generates 5 passwords with numbers, lowercase and special characters at a length of 15 characters.

        password        phonetic
        --------        --------
        01@6f43nqn%!<25 zero one at six foxtrot four three november quebec november percent exclamation less-than two five   
        o0q-mj254e,*r^- oscar zero quebec dash mike juliet two five four echo comma star romeo caret dash
        ^s)79sz4!(*-o0. caret sierra right-paren seven nine sierra zulu four exclamation left-paren star dash oscar zero dot 
        gw,hj)pi7w,xk7j golf whiskey comma hotel juliet right-paren pappa india seven whiskey comma xray kilo seven juliet   
        `$%lfn<w39lt.1h back-tick dollar percent lima foxtrot november less-than whiskey three nine lima tango dot one hotel

        .EXAMPLE
        PS C:\> New-PasswordWolf -upper on -lower off -numbers off -special off -length 15 -repeat 1

        This Example generates 1 password with uppercasecharacters at a length of 15 characters.

        password        phonetic
        --------        --------
        QFJZKCVADEDQEPH QUEBEC FOXTROT JULIET ZULU KILO CHARLIE VICTOR ALPHA DELTA ECHO DELTA QUEBEC ECHO PAPPA HOTEL

        .EXAMPLE
        PS C:\> New-PasswordWolf -upper off -lower on -numbers off -special off -length 15 -repeat 1

        This Example generates 1 password with lowercase characters at a length of 15 characters.

        password        phonetic
        --------        --------
        iredgqzsjjfliir india romeo echo delta golf quebec zulu sierra juliet juliet foxtrot lima india india romeo

        .EXAMPLE
        PS C:\> New-PasswordWolf -upper on -lower off -numbers on -special on -length 10 -repeat 2 -WhatIf

        This Example uses WhatIf to show the outcome of the command to generates 2 passwords with numbers, uppercase and special characters at a length of 10 characters.

        What if: Performing the operation "Invoke-RestMethod" on target "https://passwordwolf.com/api/?length=10&upper=on&lower=off&numbers=on&special=on&repeat=2".

        .INPUTS
        [switch]    upper       - Default = on
        [switch]    lower       - Default = off
        [switch]    numbers     - Default = on
        [switch]    special     - Default = on
        [int]       length      - Default = 10
        [int]       repeat      - Default = 2

        .OUTPUTS
        [String] password
        [String] phonetic

        .NOTES
        Function to generate secure passwords by accessing an API and parsing the JSON.
        Website: https://passwordwolf.com
        Information regarding the API and access to the Web Interface can be found at the PasswordWolf website.

        .FUNCTIONALITY
        A function providing granular control over generating passwords, utilising an API to create secure passwords in a variety of configurations.
    #>

    [CmdletBinding(DefaultParameterSetName = 'Default',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    [Alias('ngp')]
    [OutputType([String])]
    Param (
        # Turns the upper case characters on or off. Value can be On or Off. On will enable uppercase characters. Default value is off.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $upper = 'off',
    
        # Turns the lower case characters on or off. Value can be On or Off. On will enable lowercase characters. Default value is on.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $lower = 'on',
    
        # Turns numbers on or off. Value can be On or Off. On will enable numbers. Default value is on.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $numbers = 'on',
    
        # Turns special characters on or off. Value can be On or Off. On will enable special characters. Default value is off.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateSet ('on', 'off')]
        [string]
        $special = 'off',
    
        # Set the password length. Value can be between 1 - 128. Specifies the length of the password generated. Length defaults to 10 characters.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateRange (1 , 128)]
        [int]
        $length = 10,
    
        # Indicates which characters to exclude. String Value, enter special characters that you want to exclude. Default exclusion values '?!<>li1I08OB'
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [string]
        $exclude = "?!<>li1I08OB",
    
        # Indicates how many passwords to generate. Enter the number of passwords that you want to generate. Default value is 5 and will generate 5 passwords if a value is not specified.
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromRemainingArguments = $false, 
            ParameterSetName = 'Default')]
        [ValidateRange (1 , 128)]
        [int]
        $repeat = 5
    
    )
        
    begin {
    
    }
        
    process {
    
        $endpoint = "https://passwordwolf.com/api/?"
        $long = "length=$($length)"
        $up = "&upper=$($upper)"
        $low = "&lower=$($lower)"
        $num = "&numbers=$($numbers)"
        $spec = "&special=$($special)"
        $rep = "&repeat=$($repeat)"
        $uri = $endpoint + $long + $up + $low + $num + $spec + $rep
    
        if ($pscmdlet.ShouldProcess("$uri", "Invoke-RestMethod")) {
            Invoke-RestMethod -Method Get -Uri $uri
        }
    
    }
        
    end {
    
    }
}

function New-PasswordPattern {

    <#
        .SYNOPSIS
        Password Function created wrapping the New-PasswordWolf Function, to provision password templates. Pre-configured password layouts, can be selected from a tabbed list.

        .DESCRIPTION
        Password Function created wrapping the New-PasswordWolf Function, to provision password templates. Pre-configured password layouts, can be selected from a tabbed list.
        
        .EXAMPLE
        PS C:\> New-PasswordPattern -Pattern Default

        Generates a password and the phonetics for the password, using the Defaults for each parameter within the New-PasswordWolf function, retaining the original output.

        password      phonetic
        --------      --------
        zz`_B8hq3>hBS zulu zulu back-tick underscore BRAVO eight hotel quebec three greater-than hotel BRAVO SIERRA

        .EXAMPLE
        PS C:\> New-PasswordPattern -Pattern 814
        
        Generates a single password and the phonetics using the standard 814 (8 Alpha, 1 Symbol and 4 Numbers) used in most offices when creating new user passwords.

        password      phonetic
        --------      --------
        nMsDllWW`5347 november MIKE sierra DELTA lima lima WHISKEY WHISKEY back-tick five three four seven

        .EXAMPLE
        PS C:\> New-PasswordPattern -Pattern Upper -Quantity 5 -Length 17 -Special on -Verbose

        This Example shows verbose output and the output of the command to generate 5 passwords with uppercase and special characters at a length of 17 characters.

        VERBOSE: Performing the operation "New-PasswordWolf" on target "Upper Pattern".
        VERBOSE: GET https://passwordwolf.com/api/?length=17&upper=on&lower=off&numbers=off&special=on&repeat=5 with 0-byte payload
        VERBOSE: received -byte response of content type application/json
        VERBOSE: Content encoding: utf-8

        password          phonetic
        --------          --------
        ERLZHO^VL,J)LFO%@ ECHO ROMEO LIMA ZULU HOTEL OSCAR caret VICTOR LIMA comma JULIET right-paren LIMA FOXTROT OSCAR percent at
        *PZVC`^>C?G^`SY?L star PAPPA ZULU VICTOR CHARLIE back-tick caret greater-than CHARLIE question-mark GOLF caret back-tick SIERRA YANKEE question-mark LIMA
        (@A#A%IR>PE>*F.IE left-paren at ALPHA pound ALPHA percent INDIA ROMEO greater-than PAPPA ECHO greater-than star FOXTROT dot INDIA ECHO
        #(R`N(#RAR@G#`IB* pound left-paren ROMEO back-tick NOVEMBER left-paren pound ROMEO ALPHA ROMEO at GOLF pound back-tick INDIA BRAVO star
        JK)@CD^*%!XZTC$CL JULIET KILO right-paren at CHARLIE DELTA caret star percent exclamation XRAY ZULU TANGO CHARLIE dollar CHARLIE LIMA

        .EXAMPLE
        PS C:\> New-PasswordPattern -Pattern Default -Quantity 5 -Length 23 -Special off -Verbose

        This Example shows verbose output and the output of the command to generate 5 passwords with the Default template and disabling the special characters, at a length of 23 characters.

        VERBOSE: Performing the operation "New-PasswordWolf" on target "Default Pattern".
        VERBOSE: GET https://passwordwolf.com/api/?length=23&upper=on&lower=on&numbers=on&special=off&repeat=5 with 0-byte payload
        VERBOSE: received -byte response of content type application/json
        VERBOSE: Content encoding: utf-8

        password                phonetic
        --------                --------
        zemJ4nNgdPWfwwZX4u7kEr8 zulu echo mike JULIET four november NOVEMBER golf delta PAPPA WHISKEY foxtrot whiskey whiskey ZULU XRAY four uniform seven kilo ECHO romeo eight
        n6ofR4zZ3QHAM94Hd4idJik november six oscar foxtrot ROMEO four zulu ZULU three QUEBEC HOTEL ALPHA MIKE nine four HOTEL delta four india delta JULIET india kilo
        JGu0Su7ewT48d4DpijAmeYu JULIET GOLF uniform zero SIERRA uniform seven echo whiskey TANGO four eight delta four DELTA pappa india juliet ALPHA mike echo YANKEE uniform
        YP3RLoLSLtF54ul7hMBoWiI YANKEE PAPPA three ROMEO LIMA oscar LIMA SIERRA LIMA tango FOXTROT five four uniform lima seven hotel MIKE BRAVO oscar WHISKEY india INDIA
        XH1ROndLsSEF8wDQzyu9k4h XRAY HOTEL one ROMEO OSCAR november delta LIMA sierra SIERRA ECHO FOXTROT eight whiskey DELTA QUEBEC zulu yankee uniform nine kilo four hotel

        .INPUTS
        [string]    Pattern     - Default, 814, Upper, Lower, Number
        [int]       Quantity    - Default = 1
        [int]       Length      - Default = 10
        [int]       Special     - Default = on

        .OUTPUTS
        [String] password
        [String] phonetic

        .NOTES
        Function to generate secure passwords by accessing an API and parsing the JSON.
        Website: https://passwordwolf.com
        Information regarding the API and access to the Web Interface can be found at the PasswordWolf website.

        .FUNCTIONALITY
        A function providing templates for the function New-PasswordWolf, generating passwords, utilising an API to create secure passwords in a variety of configurations.
    #>

    [CmdletBinding(DefaultParameterSetName = 'Default',
        SupportsShouldProcess = $true,
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    [Alias('npp')]
    [OutputType([String])]
    param (
        # Select the pre-configured password template. Value can be 'Default', '814', 'Upper', 'Lower', 'Number'. Default value creates a single password using the API defaults.
        [Parameter(Mandatory = $false)]
        [ValidateSet ('Default', '814', 'Upper', 'Lower', 'Number')]
        [string]
        $Pattern,
        
        # Indicates how many passwords to generate. Enter the number of passwords that you want to generate. Default value is 1 and will generate a single password if a value is not specified.
        [Parameter(Mandatory = $false)]
        [ValidateRange (1, 128)]
        [int]
        $Quantity = 1,
        
        # Set the password length. Value can be between 1 - 128. Specifies the length of the password generated. Length defaults to 13 characters.
        [Parameter(Mandatory = $false)]
        [ValidateRange (1, 128)]
        [int]
        $Length = 13,

        # Turns special characters on or off. Value can be On or Off. On will enable special characters. Default value is on.
        [Parameter(Mandatory = $false)]
        [ValidateSet ('on', 'off')]
        [string]
        $Special = 'on'

    )
    
    begin {
        
    }
    
    process {
        
        switch ($Pattern) {
            814 {
                try {
                    if ($pscmdlet.ShouldProcess("814 Pattern", "New-PasswordWolf")) {
                        $8 = New-PasswordWolf -upper on -lower on -numbers off -special off -length 8 -repeat 1
                        $1 = New-PasswordWolf -upper off -lower off -numbers off -special on -length 1 -repeat 1
                        $4 = New-PasswordWolf -upper off -lower off -numbers on -special off -length 4 -repeat 1
                        $properties = @{
                            password = $8.password + $1.password + $4.password
                            phonetic = $8.phonetic + $1.phonetic + $4.phonetic
                        }
                        $obj = New-Object -TypeName psobject -Property $properties
                        Write-Output -InputObject $obj
                    }
                }
                catch {
                    Write-Error -Message $_.Exception.Message
                }
            }
            Upper {
                try {
                    if ($pscmdlet.ShouldProcess("Upper Pattern", "New-PasswordWolf")) {
                        New-PasswordWolf -upper on -lower off -numbers off -special $Special -length $Length -repeat $Quantity
                    }
                }
                catch {
                    Write-Error -Message $_.Exception.Message
                }
            }
            Lower {
                try {
                    if ($pscmdlet.ShouldProcess("Lower Pattern", "New-PasswordWolf")) {
                        New-PasswordWolf -upper off -lower on -numbers on -special $Special -length $Length -repeat $Quantity
                    }
                }
                catch {
                    Write-Error -Message $_.Exception.Message
                }
            }
            Number {
                try {
                    if ($pscmdlet.ShouldProcess("Number Pattern", "New-PasswordWolf")) {
                        New-PasswordWolf -upper off -lower off -numbers on -special $Special -length $Length -repeat $Quantity
                    }
                }
                catch {
                    Write-Error -Message $_.Exception.Message
                }
            }
            Default {
                try {
                    if ($pscmdlet.ShouldProcess("Default Pattern", "New-PasswordWolf")) {
                        New-PasswordWolf -upper on -lower on -numbers on -special $Special -length $Length -repeat $Quantity
                    }
                }
                catch {
                    Write-Error -Message $_.Exception.Message
                }
            }
        }
    }

    
    end {
        
    }

}

Export-ModuleMember -Function '*' -Alias '*' -Cmdlet '*'
