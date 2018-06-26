---
external help file: PSRhapsody-help.xml
Module Name: PSRhapsody
online version:
schema: 2.0.0
---

# Disconnect-Rhapsody

## SYNOPSIS
"Disconnect" from the current Rhapsody instance.

## SYNTAX

```
Disconnect-Rhapsody [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Technically this just removes the connection configuration from memory, so other
cmdlets can't run.
I may add session support down the road, but there's not actually
a persistent connection.

## EXAMPLES

### EXAMPLE 1
```
Disconnect-Rhapsody
```

Removes any Rhapsody connection information from memory.

## PARAMETERS

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
