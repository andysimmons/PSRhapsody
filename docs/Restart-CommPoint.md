---
external help file: PSRhapsody-help.xml
Module Name: PSRhapsody
online version:
schema: 2.0.0
---

# Restart-CommPoint

## SYNOPSIS
Restarts a communication point.

## SYNTAX

```
Restart-CommPoint [-CommunicationPoint] <CommPoint[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Restarts a communication point.

## EXAMPLES

### EXAMPLE 1
```
Get-CommPoint -Id 6223 | Restart-CommPoint
```

Retrieves the commpoint object with ID 6223 and restarts it.

## PARAMETERS

### -CommunicationPoint
CommPoint object to be restarted.

```yaml
Type: CommPoint[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
