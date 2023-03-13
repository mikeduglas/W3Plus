!** WHO/WHERE/WHAT extensions.
!** 13.03.2023
!** mikeduglas@yandex.ru

  MODULE('w3plus')
    !!! <summary>
    !!! Returns a string containing the long name of a specified field from a group structure.
    !!! </summary>
    !!! <param name="pGrp">The label of a GROUP, RECORD, CLASS, or QUEUE declaration.</param>
    !!! <param name="pLabel">The label of a field in the group declaration.</param>
    !!! <returns>String containing the long name of the field from a group structure</returns>        
    WhoPlus(*GROUP pGrp, *? pLabel), STRING

    !!! <summary>
    !!! Returns a field's ordinal position within a GROUP, RECORD, CLASS, or QUEUE structure.
    !!! </summary>
    !!! <param name="pGrp">The label of a GROUP, RECORD, CLASS, or QUEUE declaration.</param>
    !!! <param name="pName">The short or long name of a field in the group declaration.</param>
    !!! <returns>The ordinal position of a name specified field in a group structure</returns>        
    WherePlus(*GROUP pGrp, STRING pName), SIGNED

    !!! <summary>
    !!! Returns a specified field from a group structure.
    !!! </summary>
    !!! <param name="pGrp">The label of a GROUP, RECORD, CLASS, or QUEUE declaration.</param>
    !!! <param name="pName">The short or long name of a field in the group declaration.</param>
    !!! <returns>The name specified field from a group structure.</returns>        
    WhatPlus(*GROUP pGrp, STRING pName), *?
  END

  PRAGMA('compile(w3plus.clw)')
