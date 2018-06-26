---
external help file: PSRhapsody-help.xml
Module Name: PSRhapsody
online version:
schema: 2.0.0
---

# Connect-Rhapsody

## SYNOPSIS
Connects to a Rhapsody server.

## SYNTAX

```
Connect-Rhapsody [-Credential] <PSCredential> [-BaseUri] <Uri> [-SkipCertificateCheck] [-Force]
 [<CommonParameters>]
```

## DESCRIPTION
Connects to a Rhapsody server.

## EXAMPLES

### EXAMPLE 1
```
Connect-Rhapsody -BaseUri 'https://your.rhapsody.server:8444'
```

Connects to the Rhapsody server via HTTPS on port 8444, prompting for credentials.

## PARAMETERS

### -Credential
Credentials used for authentication.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BaseUri
Base URI of the Rhapsody REST API.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: Https://rhapsodyindev01.slhs.org:8444
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipCertificateCheck
Bypass SSL certificate validation (e.g.
if the server's certificate
is self-signed)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces an update to the connection configuration used by other cmdlets in this
module, even if the connection attempt fails.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
