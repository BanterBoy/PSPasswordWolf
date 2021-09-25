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
