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
DIM n AS INTEGER
PRINT "1 for Displacement"
PRINT "2 for Velocity"
PRINT "3 for Acceleration"
PRINT "4 to plot all of the above"

DO
    INPUT "Choose one of the following options: ", n
LOOP WHILE n < 1 OR n > 4

DIM c AS INTEGER

SCREEN 12
FOR c = 1 TO 15
    'CLS
    DRAW_AXES
    ON ERROR GOTO handler
    MOVE_POINT radius, c, n
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

SUB MOVE_POINT (radius AS DOUBLE, c AS INTEGER, n AS INTEGER)
    DIM x AS DOUBLE
    DIM y AS DOUBLE
    DIM h AS INTEGER
    DIM c1 AS INTEGER
    DIM c2 AS INTEGER
    DIM c3 AS INTEGER
    DIM d AS DOUBLE

    d = .0005
    FOR i = 0.0 TO 2 * PI STEP d
        IF h <> 0 THEN
            CIRCLE (MID_COL, y * SCALE_FACTOR + MID_ROW), DOT_SIZE * SCALE_FACTOR, 0
            COLOR 15
        END IF

        x = radius * COS(i)
        y = -radius * SIN(i)

        CIRCLE (x * SCALE_FACTOR + MID_COL, y * SCALE_FACTOR + MID_ROW), DOT_SIZE * SCALE_FACTOR, c
        CIRCLE (MID_COL, y * SCALE_FACTOR + MID_ROW), DOT_SIZE * SCALE_FACTOR, 15

        c1 = increment(c)
        c2 = increment(c1)
        c3 = increment(c2)

        COLOR c
        LOCATE 1, 1
        PRINT USING "Angle in degrees: ###.##"; i * 180 / PI
        LOCATE 2, 1
        PRINT USING "Circle: (###.##,###.##)"; x; -y
        COLOR 15
        LOCATE 3, 1
        PRINT USING "Projection: (###.##,###.##)"; 0; -y


        IF n = 1 THEN
            plot i, COS(i + PI / 2), radius, c1, 4, "Displacement: (###.##,###.##)"
        END IF

        IF n = 2 THEN
            plot i, -SIN(i + PI / 2), radius, c2, 4, "Velocity: (###.##,###.##)"
        END IF

        IF n = 3 THEN
            plot i, -COS(i + PI / 2), radius, c3, 4, "Acceleration: (###.##,###.##)"
        END IF

        IF n = 4 THEN
            plot i, COS(i + PI / 2), radius, c1, 4, "Displacement: (###.##,###.##)"
            plot i, -SIN(i + PI / 2), radius, c2, 5, "Velocity: (###.##,###.##)"
            plot i, -COS(i + PI / 2), radius, c3, 6, "Acceleration: (###.##,###.##)"
        END IF
        h = 1
    NEXT
END SUB

SUB plot (x AS DOUBLE, y AS DOUBLE, radius AS DOUBLE, c AS INTEGER, row AS INTEGER, s AS STRING)
    PSET (x * SCALE_FACTOR + MID_COL, y * SCALE_FACTOR * radius + MID_ROW), c
    COLOR c
    LOCATE row, 1
    PRINT USING s; x, y
END SUB


FUNCTION increment (c AS INTEGER)
    DIM c1 AS INTEGER
    c1 = c + 1
    IF c1 = 15 THEN c1 = 1
    increment = c1
END FUNCTION
SUB Delay (dlay!)
    start! = TIMER
    DO WHILE start! + dlay! >= TIMER
        IF start! > TIMER THEN start! = start! - 86400
    LOOP
END SUB

