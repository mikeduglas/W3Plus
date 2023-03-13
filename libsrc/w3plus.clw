!** WHO/WHERE/WHAT extensions.
!** 13.03.2023
!** mikeduglas@yandex.ru

  MEMBER

  MAP
    INCLUDE('w3plus.inc'), ONCE
  END
  
WhoPlus                       PROCEDURE(*GROUP pGrp, *? pLabel)
fldPos                          SIGNED, AUTO
fldRef                          ANY
grpRef                          &GROUP, AUTO
i                               LONG, AUTO
fldFullName                     STRING(256), AUTO
  CODE
  fldPos = WHERE(pGrp, pLabel)
  IF fldPos = 0
    !- the field is not a member of this group
    RETURN ''
  END

  fldFullName = ''
  
  LOOP i=1 TO fldPos-1
    fldRef &= WHAT(pGrp, i)
    IF ISGROUP(pGrp, i)
      grpRef &= GETGROUP(pGrp, i)
      IF WHERE(grpRef, pLabel) > 0
        !- the label is a member of this inner group,
        !- so append a group name and a dot.
        fldFullName = CLIP(fldFullName) & WHO(pGrp, i) &'.'
      END
    END
  END

  !- append a label name itself.
  fldFullName = CLIP(fldFullName) & WHO(pGrp, fldPos)
  RETURN fldFullName

WherePlus                     PROCEDURE(*GROUP pGrp, STRING pName)
fldRef                          ANY
fldName                         STRING(256), AUTO
bIsCompoundName                 BOOL, AUTO  !- pName is compound name (contains . separator(s))
i                               LONG, AUTO
  CODE
  bIsCompoundName = CHOOSE(INSTRING('.', pName, 1, 1) > 0)
  pName = UPPER(pName)
  LOOP i=1 TO 1000
    fldRef &= WHAT(pGrp, i)
    IF fldRef &= NULL
      !- no more fields in the group.
      RETURN 0
    END
    
    fldName = CHOOSE(bIsCompoundName = FALSE, WHO(pGrp, i), WhoPlus(pGrp, fldRef))
    IF UPPER(fldName) = pName
      !- exact macth found.
      RETURN i
    END
  END

  RETURN 0

WhatPlus                      PROCEDURE(*GROUP pGrp, STRING pName)
fldRef                          ANY
fldName                         STRING(256), AUTO
bIsCompoundName                 BOOL, AUTO  !- pName is compound name (contains . separator(s))
i                               LONG, AUTO
  CODE
  bIsCompoundName = CHOOSE(INSTRING('.', pName, 1, 1) > 0)
  pName = UPPER(pName)
  LOOP i=1 TO 1000
    fldRef &= WHAT(pGrp, i)
    IF fldRef &= NULL
      !- no more fields in the group.
      BREAK
    END
    
    fldName = CHOOSE(bIsCompoundName = FALSE, WHO(pGrp, i), WhoPlus(pGrp, fldRef))
    IF UPPER(fldName) = pName
      !- exact macth found.
      BREAK
    END
  END

  RETURN fldRef
