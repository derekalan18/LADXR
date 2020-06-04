RenderChestItem:
        ldh  a, [$F1] ; active sprite
        and  $80
        jr   nz, .renderLargeItem

        ld   de, ItemSpriteTable
        call $3C77 ; RenderActiveEntitySprite
        ret
.renderLargeItem:
        ld   de, LargeItemSpriteTable
        dec  d
        dec  d
        call $3BC0 ; RenderActiveEntitySpritePair
        ret

SendItemFromChestToOtherGame:
        ldh  a, [$F1] ; Load active sprite variant
        call LinkSendByte
        ld   a, $F1   ; link command, give item
        call LinkSendByte
        ret

GiveItemFromChest:
        ; Check our "item is for other player" flag
        ld   hl, $7300
        call OffsetPointerByRoomNumber
        ld   a, [hl]
        and  a
        jr   nz, SendItemFromChestToOtherGame

GiveItemFromChestNoLink:
        ldh  a, [$F1] ; Load active sprite variant

        rst  0 ; JUMP TABLE
        dw ChestPowerBracelet; CHEST_POWER_BRACELET
        dw ChestShield       ; CHEST_SHIELD
        dw ChestBow          ; CHEST_BOW
        dw ChestWithItem     ; CHEST_HOOKSHOT
        dw ChestWithItem     ; CHEST_MAGIC_ROD
        dw ChestWithItem     ; CHEST_PEGASUS_BOOTS
        dw ChestWithItem     ; CHEST_OCARINA
        dw ChestWithItem     ; CHEST_FEATHER
        dw ChestWithItem     ; CHEST_SHOVEL
        dw ChestWithItem     ; CHEST_MAGIC_POWDER_BAG
        dw ChestWithItem     ; CHEST_BOMB
        dw ChestSword        ; CHEST_SWORD
        dw Flippers          ; CHEST_FLIPPERS
        dw NoItem            ; CHEST_MAGNIFYING_LENS
        dw ChestWithItem    ; Boomerang (used to be unused)
        dw SlimeKey         ; ?? right side of your trade quest item
        dw Medicine         ; CHEST_MEDICINE
        dw TailKey          ; CHEST_TAIL_KEY
        dw AnglerKey        ; CHEST_ANGLER_KEY
        dw FaceKey          ; CHEST_FACE_KEY
        dw BirdKey          ; CHEST_BIRD_KEY
        dw GoldenLeaf       ; CHEST_GOLD_LEAF
        dw ChestWithCurrentDungeonItem ; CHEST_MAP
        dw ChestWithCurrentDungeonItem ; CHEST_COMPASS
        dw ChestWithCurrentDungeonItem ; CHEST_STONE_BEAK
        dw ChestWithCurrentDungeonItem ; CHEST_NIGHTMARE_KEY
        dw ChestWithCurrentDungeonItem ; CHEST_SMALL_KEY
        dw AddRupees50      ; CHEST_RUPEES_50
        dw AddRupees20      ; CHEST_RUPEES_20
        dw AddRupees100     ; CHEST_RUPEES_100
        dw AddRupees200     ; CHEST_RUPEES_200
        dw AddRupees500     ; CHEST_RUPEES_500
        dw AddSeashell      ; CHEST_SEASHELL
        dw NoItem           ; CHEST_MESSAGE
        dw NoItem           ; CHEST_GEL
        dw AddKey ; KEY1
        dw AddKey ; KEY2
        dw AddKey ; KEY3
        dw AddKey ; KEY4
        dw AddKey ; KEY5
        dw AddKey ; KEY6
        dw AddKey ; KEY7
        dw AddKey ; KEY8
        dw AddKey ; KEY9
        dw AddMap ; MAP1
        dw AddMap ; MAP2
        dw AddMap ; MAP3
        dw AddMap ; MAP4
        dw AddMap ; MAP5
        dw AddMap ; MAP6
        dw AddMap ; MAP7
        dw AddMap ; MAP8
        dw AddMap ; MAP9
        dw AddCompass ; COMPASS1
        dw AddCompass ; COMPASS2
        dw AddCompass ; COMPASS3
        dw AddCompass ; COMPASS4
        dw AddCompass ; COMPASS5
        dw AddCompass ; COMPASS6
        dw AddCompass ; COMPASS7
        dw AddCompass ; COMPASS8
        dw AddCompass ; COMPASS9
        dw AddStoneBeak ; STONE_BEAK1
        dw AddStoneBeak ; STONE_BEAK2
        dw AddStoneBeak ; STONE_BEAK3
        dw AddStoneBeak ; STONE_BEAK4
        dw AddStoneBeak ; STONE_BEAK5
        dw AddStoneBeak ; STONE_BEAK6
        dw AddStoneBeak ; STONE_BEAK7
        dw AddStoneBeak ; STONE_BEAK8
        dw AddStoneBeak ; STONE_BEAK9
        dw AddNightmareKey ; NIGHTMARE_KEY1
        dw AddNightmareKey ; NIGHTMARE_KEY2
        dw AddNightmareKey ; NIGHTMARE_KEY3
        dw AddNightmareKey ; NIGHTMARE_KEY4
        dw AddNightmareKey ; NIGHTMARE_KEY5
        dw AddNightmareKey ; NIGHTMARE_KEY6
        dw AddNightmareKey ; NIGHTMARE_KEY7
        dw AddNightmareKey ; NIGHTMARE_KEY8
        dw AddNightmareKey ; NIGHTMARE_KEY9
        dw NoItem ; $50
        dw NoItem ; $51
        dw NoItem ; $52
        dw NoItem ; $53
        dw NoItem ; $54
        dw NoItem ; $55
        dw NoItem ; $56
        dw NoItem ; $57
        dw NoItem ; $58
        dw NoItem ; $59
        dw NoItem ; $5A
        dw NoItem ; $5B
        dw NoItem ; $5C
        dw NoItem ; $5D
        dw NoItem ; $5E
        dw NoItem ; $5F
        dw NoItem ; $60
        dw NoItem ; $61
        dw NoItem ; $62
        dw NoItem ; $63
        dw NoItem ; $64
        dw NoItem ; $65
        dw NoItem ; $66
        dw NoItem ; $67
        dw NoItem ; $68
        dw NoItem ; $69
        dw NoItem ; $6A
        dw NoItem ; $6B
        dw NoItem ; $6C
        dw NoItem ; $6D
        dw NoItem ; $6E
        dw NoItem ; $6F
        dw NoItem ; $70
        dw NoItem ; $71
        dw NoItem ; $72
        dw NoItem ; $73
        dw NoItem ; $74
        dw NoItem ; $75
        dw NoItem ; $76
        dw NoItem ; $77
        dw NoItem ; $78
        dw NoItem ; $79
        dw NoItem ; $7A
        dw NoItem ; $7B
        dw NoItem ; $7C
        dw NoItem ; $7D
        dw NoItem ; $7E
        dw NoItem ; $7F
        dw PieceOfHeart     ; Heart piece
        dw GiveBowwow

NoItem:
        ret

ChestPowerBracelet:
        ld   hl, $DB43 ; power bracelet level
        jr   ChestIncreaseItemLevel

ChestShield:
        ld   hl, $DB44 ; shield level
        jr   ChestIncreaseItemLevel

ChestSword:
        ld   hl, $DB4E ; sword level
        jr   ChestIncreaseItemLevel

ChestIncreaseItemLevel:
        ld   a, [hl]
        cp   $02
        jr   z, DoNotIncreaseItemLevel
        inc  [hl]
DoNotIncreaseItemLevel:
        jp   ChestWithItem

ChestBow:
        ld   a, [$DB45]
        cp   $20
        jp   nc, ChestWithItem
        ld   a, $20
        ld   [$DB45], a
        jp   ChestWithItem

Flippers:
        ld   a, $01
        ld   [$DB0C], a
        ret

Medicine:
        ld   a, $01
        ld   [$DB0D], a
        ret

TailKey:
        ld   a, $01
        ld   [$DB11], a
        ret

AnglerKey:
        ld   a, $01
        ld   [$DB12], a
        ret

FaceKey:
        ld   a, $01
        ld   [$DB13], a
        ret

BirdKey:
        ld   a, $01
        ld   [$DB14], a
        ret

SlimeKey:
        ld   a, $01
        ld   [$DB15], a
        ret

GoldenLeaf:
        ld   hl, $DB6D
        inc  [hl]
        ret

AddSeaShell:
        ld   a, [$DB0F]
        inc  a
        daa
        ld   [$DB0F], a
        ret

PieceOfHeart:
        ld   a, [$DB5C]
        inc  a
        cp   $04
        jr   z, .FullHeart
        ld   [$DB5C], a
        ret
.FullHeart:
        xor  a
        ld   [$DB5C], a
        ld   hl, $DB93
        ld   [hl], $40 ; Regen HP
        ld   hl, $DB5B
        inc  [hl]      ; Add max health
        ret

GiveBowwow:
        ld   a, $01
        ld   [$DB56], a
        ret

ChestInventoryTable:
        db   $03 ; CHEST_POWER_BRACELET
        db   $04 ; CHEST_SHIELD
        db   $05 ; CHEST_BOW
        db   $06 ; CHEST_HOOKSHOT
        db   $07 ; CHEST_MAGIC_ROD
        db   $08 ; CHEST_PEGASUS_BOOTS
        db   $09 ; CHEST_OCARINA
        db   $0A ; CHEST_FEATHER
        db   $0B ; CHEST_SHOVEL
        db   $0C ; CHEST_MAGIC_POWDER_BAG
        db   $02 ; CHEST_BOMB
        db   $01 ; CHEST_SWORD
        db   $00 ; - (flippers slot)
        db   $00 ; - (magnifier lens slot)
        db   $0D ; Boomerang

ChestWithItem:
        ldh  a, [$F1] ; Load active sprite variant
        ld   d, $00
        ld   e, a
        ld   hl, ChestInventoryTable
        add  hl, de
        ld   d, [hl]
        call $3E6B ; Give Inventory
        ret

ChestWithCurrentDungeonItem:
        sub  $16 ; a -= CHEST_MAP
        ld   e, a
        ld   d, $00
        ld   hl, $DBCC ; hasDungeonMap
        add  hl, de
        inc  [hl]
        call $2802  ; Sync current dungeon items with dungeon specific table
        ret

AddKey:
        sub $23 ; Make 'A' target dungeon index
        ld   de, $0004
        jr   AddDungeonItem

AddMap:
        sub $2C ; Make 'A' target dungeon index
        ld   de, $0000
        jr   AddDungeonItem

AddCompass:
        sub $35 ; Make 'A' target dungeon index
        ld   de, $0001
        jr   AddDungeonItem

AddStoneBeak:
        sub $3E ; Make 'A' target dungeon index
        ld   de, $0002
        jr   AddDungeonItem

AddNightmareKey:
        sub $47 ; Make 'A' target dungeon index
        ld   de, $0003
        jr   AddDungeonItem

AddDungeonItem:
        cp   $08
        jr   z, .colorDungeon
        ; hl = dungeonitems + type_type + dungeon * 8
        ld   hl, $DB16
        add  hl, de
        push de
        ld   e, a
        add  hl, de
        add  hl, de
        add  hl, de
        add  hl, de
        add  hl, de
        pop  de
        inc  [hl]
        ; Check if we are in this specific dungeon, and then increase the copied counters as well.
        ld   hl, $FFF7   ; is current map == target map
        cp   [hl]
        ret  nz
        ld   a, [$DBA5] ; is indoor
        and  a
        ret  z

        ld   hl, $DBCC
        add  hl, de
        inc  [hl]
        ret
.colorDungeon:
        ; Special case for the color dungeon, which is in a different location in memory.
        ld   hl, $DDDA
        add  hl, de
        inc  [hl]
        ldh  a, [$F7]   ; is current map == color dungeon
        cp   $ff
        ret  nz
        ld   hl, $DBCC
        add  hl, de
        inc  [hl]
        ret

AddRupees20:
        xor  a
        ld   h, $14
        jr   AddRupees

AddRupees50:
        xor  a
        ld   h, $32
        jr   AddRupees

AddRupees100:
        xor  a
        ld   h, $64
        jr   AddRupees

AddRupees200:
        xor  a
        ld   h, $C8
        jr   AddRupees

AddRupees500:
        ld   a, $01
        ld   h, $F4
        jr   AddRupees

AddRupees:
        ld   [$DB8F], a
        ld   a, h
        ld   [$DB90], a
        ld   a, $18
        ld   [$C3CE], a
        ret

ItemMessageForLink:
        ld   a, $C9
        jp  $2385 ; Opendialog in $000-$0FF range

ItemMessage:
        ; Check our "item is for other player" flag
        ld   hl, $7300
        call OffsetPointerByRoomNumber
        ld   a, [hl]
        and  a
        jr   nz, ItemMessageForLink

ItemMessageNoLink:
        ldh  a, [$F1]
        ld   d, $00
        ld   e, a
        ld   hl, ItemMessageTable
        add  hl, de
        ld   a, [hl]
        jp   $2385 ; Opendialog in $000-$0FF range

ItemSpriteTable:
        db $82, $15        ; CHEST_POWER_BRACELET
        db $86, $15        ; CHEST_SHIELD
        db $88, $14        ; CHEST_BOW
        db $8A, $14        ; CHEST_HOOKSHOT
        db $8C, $14        ; CHEST_MAGIC_ROD
        db $98, $16        ; CHEST_PEGASUS_BOOTS
        db $90, $17        ; CHEST_OCARINA
        db $92, $15        ; CHEST_FEATHER
        db $96, $17        ; CHEST_SHOVEL
        db $8E, $14        ; CHEST_MAGIC_POWDER_BAG
        db $80, $15        ; CHEST_BOMB
        db $84, $15        ; CHEST_SWORD
        db $94, $15        ; CHEST_FLIPPERS
        db $9A, $10        ; CHEST_MAGNIFYING_LENS
        db $24, $1C        ; Boomerang
        db $4E, $1C        ; Slime key
        db $A0, $14        ; CHEST_MEDICINE
        db $30, $1C        ; CHEST_TAIL_KEY
        db $32, $1C        ; CHEST_ANGLER_KEY
        db $34, $1C        ; CHEST_FACE_KEY
        db $36, $1C        ; CHEST_BIRD_KEY
        db $3A, $1C        ; CHEST_GOLD_LEAF
        db $40, $1C        ; CHEST_MAP
        db $42, $1D        ; CHEST_COMPASS
        db $44, $1C        ; CHEST_STONE_BEAK
        db $46, $1C        ; CHEST_NIGHTMARE_KEY
        db $4A, $1F        ; CHEST_SMALL_KEY
        db $A6, $15        ; CHEST_RUPEES_50 (normal blue)
        db $38, $19        ; CHEST_RUPEES_20 (red)
        db $38, $18        ; CHEST_RUPEES_100 (green)
        db $38, $1A        ; CHEST_RUPEES_200 (yellow)
        db $38, $1A        ; CHEST_RUPEES_500 (yellow)
        db $9E, $14        ; CHEST_SEASHELL
        db $FF, $18        ; CHEST_MESSAGE
        db $FF, $18        ; CHEST_GEL
        db $4A, $1D        ; KEY1
        db $4A, $1D        ; KEY2
        db $4A, $1D        ; KEY3
        db $4A, $1D        ; KEY4
        db $4A, $1D        ; KEY5
        db $4A, $1D        ; KEY6
        db $4A, $1D        ; KEY7
        db $4A, $1D        ; KEY8
        db $4A, $1D        ; KEY9
        db $40, $1C        ; MAP1
        db $40, $1C        ; MAP2
        db $40, $1C        ; MAP3
        db $40, $1C        ; MAP4
        db $40, $1C        ; MAP5
        db $40, $1C        ; MAP6
        db $40, $1C        ; MAP7
        db $40, $1C        ; MAP8
        db $40, $1C        ; MAP9
        db $42, $1D        ; COMPASS1
        db $42, $1D        ; COMPASS2
        db $42, $1D        ; COMPASS3
        db $42, $1D        ; COMPASS4
        db $42, $1D        ; COMPASS5
        db $42, $1D        ; COMPASS6
        db $42, $1D        ; COMPASS7
        db $42, $1D        ; COMPASS8
        db $42, $1D        ; COMPASS9
        db $44, $1C        ; STONE_BEAK1
        db $44, $1C        ; STONE_BEAK2
        db $44, $1C        ; STONE_BEAK3
        db $44, $1C        ; STONE_BEAK4
        db $44, $1C        ; STONE_BEAK5
        db $44, $1C        ; STONE_BEAK6
        db $44, $1C        ; STONE_BEAK7
        db $44, $1C        ; STONE_BEAK8
        db $44, $1C        ; STONE_BEAK9
        db $46, $1C        ; NIGHTMARE_KEY1
        db $46, $1C        ; NIGHTMARE_KEY2
        db $46, $1C        ; NIGHTMARE_KEY3
        db $46, $1C        ; NIGHTMARE_KEY4
        db $46, $1C        ; NIGHTMARE_KEY5
        db $46, $1C        ; NIGHTMARE_KEY6
        db $46, $1C        ; NIGHTMARE_KEY7
        db $46, $1C        ; NIGHTMARE_KEY8
        db $46, $1C        ; NIGHTMARE_KEY9

LargeItemSpriteTable:
        db $AC, $02, $AC, $22 ; heart piece
        db $54, $0A, $56, $0A ; bowwow
        db $00, $0D, $22, $08 ; bomb upgrade
        db $80, $0C, $22, $08 ; arrow upgrade

ItemMessageTable:
        db $90, $3D, $89, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $D9, $A2
        db $A0, $A1, $A3, $A4, $A5, $E8, $A6, $A7, $A8, $A9, $AA, $AC, $AB, $AD, $AE, $AE
        db $EF, $BE, $00, $BF, $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $BF, $C0, $C1, $C2
        db $C3, $C4, $C5, $C6, $C7, $BF, $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $BF, $C0
        ; $40
        db $C1, $C2, $C3, $C4, $C5, $C6, $C7, $BF, $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        ; $80
        db $4F, $C8

RenderDroppedKey:
    ;TODO: See EntityInitKeyDropPoint for a few special cases to unload.

RenderHeartPiece:
    ; Check if our chest type is already loaded
    ld   hl, $C2C0
    add  hl, bc
    ld   a, [hl]
    and  a
    jr   nz, .droppedKeyTypeLoaded
    inc  [hl]

    ;Load the chest type from the chest table.
    ld   hl, $7800
    call OffsetPointerByRoomNumber

    ld   a, [hl]
    ldh  [$F1], a ; set currentEntitySpriteVariant
    call $3B0C ; SetEntitySpriteVariant

    and  $80
    ld   hl, $C340
    add  hl, bc
    ld   a, [hl]
    jr   z, .singleSprite
    ; We potentially need to fix the physics flags table to allocate 2 sprites for us
    and  $F8
    or   $02
    ld   [hl], a
    jr .droppedKeyTypeLoaded
.singleSprite:
    and  $F8
    or   $01
    ld   [hl], a
.droppedKeyTypeLoaded:
    jp RenderChestItem


OffsetPointerByRoomNumber:
    ldh  a, [$F6] ; map room
    ld   e, a
    ld   a, [$DBA5] ; is indoor
    ld   d, a
    ldh  a, [$F7]   ; mapId
    cp   $FF
    jr   nz, .notColorDungeon

    ld   d, $03
    jr   .notCavesA

.notColorDungeon:
    cp   $1A
    jr   nc, .notCavesA
    cp   $06
    jr   c, .notCavesA
    inc  d
.notCavesA:
    add  hl, de
    ret
