CLS
_TITLE "Simple Harmonic Motion"
CONST SCALE_FACTOR = 16
CONST LAST_COL = 640
CONST LAST_ROW = 480
CONST MID_COL = LAST_COL / 2
CONST MID_ROW = LAST_ROW / 2

CONST PI = 3.1415926535897932384626433832795
CONST DEG_TO_PI = PI / 180
CONST DOT_SIZE = 0.07
'begin
DIM radius AS DOUBLE
DO
    CLS
    PRINT "This program demonstrates the relationship between a 2-diminensional uniform circular motion and its projected 1-dimensional motion."
    PRINT "The long curved arc at the north and south ends of circle map to a very short distance on to the vertical axis and hence the velocity at the two ends is slow."
    PRINT "The projected motion is always accelerated toward the center - it's a classic example of Simple Harmonic Motion."
    PRINT "The graph of the velocity of the projected point on the vertical axis (against time) is a sine function."

    INPUT "Enter the radius of the closed circuit: ", radius
LOOP WHILE radius <= 0.0
DIM c AS INTEGER

SCREEN 12
FOR c = 1 TO 15
    'CLS
    DRAW_AXES
    ON ERROR GOTO handler
    MOVE_POINT radius, c
    handler:
    IF ERR > 0 THEN
        RESUME NEXT
    END IF
    Delay .01
NEXT
END
'end

SUB DRAW_AXES
    DIM x AS INTEGER
    DIM y AS INTEGER
    FOR x = 0 TO LAST_COL STEP SCALE_FACTOR
        IF x = MID_COL THEN
            LINE (x, 0)-(x, LAST_ROW), 7
        ELSE
            LINE (x, 0)-(x, LAST_ROW), 8
        END IF
    NEXT x
    FOR y = 0 TO LAST_ROW STEP SCALE_FACTOR
        IF y = MID_ROW THEN
            LINE (0, y)-(LAST_COL, y), 7
        ELSE
            LINE (0, y)-(LAST_COL, y), 8
        END IF
    NEXT y
END SUB

SUB MOVE_POINT (radius AS DOUBLE, c AS INTEGER)
    DIM x AS DOUBLE
    DIM y AS DOUBLE
    DIM h AS INTEGER
    DIM c1 AS INTEGER
    DIM c2 AS INTEGER
    DIM c3 AS INTEGER

    DIM d AS DOUBLE

    d = .0001
    FOR i = 0.0 TO 2 * PI STEP d
        IF h <> 0 THEN
            CIRCLE (MID_COL, y * SCALE_FACTOR + MID_ROW), DOT_SIZE * SCALE_FACTOR, 0
        END IF

        x = radius * COS(i)
        y = -radius * SIN(i)

        CIRCLE (x * SCALE_FACTOR + MID_COL, y * SCALE_FACTOR + MID_ROW), DOT_SIZE * SCALE_FACTOR, c
        CIRCLE (MID_COL, y * SCALE_FACTOR + MID_ROW), DOT_SIZE * SCALE_FACTOR, 15

        c1 = c + 1
        IF c1 = 15 THEN c1 = 1

        c2 = c1 + 1
        IF c2 = 15 THEN c2 = 1

        c3 = c2 + 1
        IF c3 = 15 THEN c3 = 1


        PSET (i * SCALE_FACTOR + MID_COL, (SIN(i + PI / 2)) * SCALE_FACTOR * radius + MID_ROW), c1
        PSET (i * SCALE_FACTOR + MID_COL, -COS(i + PI / 2) * SCALE_FACTOR * radius + MID_ROW), c2
        PSET (i * SCALE_FACTOR + MID_COL, -(SIN(i + PI / 2)) * SCALE_FACTOR * radius + MID_ROW), c3

        COLOR 15
        LOCATE 1, 1
        PRINT USING "Angle in degrees: ###.##"; i * 180 / PI
        LOCATE 2, 1
        PRINT USING "Circle: (###.##,###.##)"; x; -y
        LOCATE 3, 1
        PRINT USING "Projection: (###.##,###.##)"; 0; -y
        COLOR c1
        LOCATE 4, 1
        PRINT USING "Displacement: (###.##,###.##)"; i, radius * COS(i + PI / 2)
        COLOR c2
        LOCATE 5, 1
        PRINT USING "Velocity: (###.##,###.##)"; i, radius * -SIN(i + PI / 2)
        COLOR c3
        LOCATE 6, 1
        PRINT USING "Acceleration: (###.##,###.##)"; i, radius * -COS(i + PI / 2)
        h = 1
    NEXT
END SUB

SUB Delay (dlay!)
    start! = TIMER
    DO WHILE start! + dlay! >= TIMER
        IF start! > TIMER THEN start! = start! - 86400
    LOOP
END SUB

