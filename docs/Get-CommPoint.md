---
external help file: PSRhapsody-help.xml
Module Name: PSRhapsody
online version:
schema: 2.0.0
---

# Get-CommPoint

## SYNOPSIS
Retrieves one or more communication points from Rhapsody.

## SYNTAX

```
Get-CommPoint [-Id] <Int32[]> [<CommonParameters>]
```

## DESCRIPTION
Retrieves one or more communication points from Rhapsody.

## EXAMPLES

### EXAMPLE 1
```
Get-CommPoint -Id (6223..6226)
```

Retrieves communication points with IDs of 6223, 6224, 6225, 6226.

## PARAMETERS

### -Id
Specifies the communication point ID.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
