-- =============================================================================
-- Seed: endoscope '11112222111' — 20 reprocessing cycles each with exactly
--       one error, so they appear in a "singleErrorOnly=true" query result.
--
-- All IDs are in the 9900x / 9900x range to avoid collisions with real data.
-- Safe to run multiple times — every INSERT uses ON CONFLICT (id) DO NOTHING.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 1. LOOKUP ROWS
-- -----------------------------------------------------------------------------

-- Manufacturer
INSERT INTO public.manufacturer
    (id, name, creationdate, lastedit, isdeleted)
VALUES
    (9901, 'Olympus', NOW(), NOW(), false)
ON CONFLICT (id) DO NOTHING;

-- Endoscope type  (GIF-H190, 2 channels)
INSERT INTO public.endoscopetype
    (id, manufacturer_id, typename, numberofchannels, hasalbaranchannel,
     creationdate, lastedit, isdeleted, olympusdefined, actionreason_id)
VALUES
    (9901, 9901, 'GIF-H190', 2, false, NOW(), NOW(), false, false, 0)
ON CONFLICT (id) DO NOTHING;

-- Reprocessing device type  (ETD Double)
INSERT INTO public.reprocessingdevicetype
    (id, typename, maximunload, creationdate, lastedit, isdeleted, isdisabled)
VALUES
    (9901, 'ETD Double', 2, NOW(), NOW(), false, false)
ON CONFLICT (id) DO NOTHING;

-- Reprocessing device
INSERT INTO public.reprocessingdevice
    (id, reprocessingdevicetype_id, name, serialnumber, location,
     creationdate, lastedit, isdeleted, isdisabled, isquarantine)
VALUES
    (9901, 9901, 'ETD Double Test Unit', 'TEST-DEVICE-9901', 'Endoscopy Test Lab',
     NOW(), NOW(), false, false, false)
ON CONFLICT (id) DO NOTHING;

-- Cycle state  ("Failed" — name != 'Complete' means IsSuccess = false in the query)
INSERT INTO public.cyclestate
    (id, name, creationdate, lastedit)
VALUES
    (9901, 'Failed', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

-- Endoscope with serial '11112222111'
INSERT INTO public.endoscope
    (id, endoscopetype_id, serialnumber, isloanerdevice,
     creationdate, lastedit, isdeleted, isdisabled, isquarantine)
VALUES
    (9901, 9901, '11112222111', false, NOW(), NOW(), false, false, false)
ON CONFLICT (id) DO NOTHING;

-- -----------------------------------------------------------------------------
-- 2. PER-CYCLE ROWS  (gs = 1..20, IDs = 99001..99020)
--    Each cycle gets:
--      • one reprocessinghistoryitem
--      • one cycle
--      • one cyclestep  (linking cycle ↔ reprocessinghistoryitem)
--      • one etddoubleerrorprotocol  (exactly 1 error → qualifies for singleErrorOnly)
-- -----------------------------------------------------------------------------

-- reprocessinghistoryitem
INSERT INTO public.reprocessinghistoryitem
    (id, reprocessingdevice_id, creationdate, lastedit, isdeleted,
     starttime, endtime, timeincludesseconds, success,
     reprocessinghistoryitemeventtype_id, starttimereceived)
SELECT
    99000 + gs                                                      AS id,
    9901                                                            AS reprocessingdevice_id,
    NOW()                                                           AS creationdate,
    NOW()                                                           AS lastedit,
    false                                                           AS isdeleted,
    NOW() - (gs || ' days')::interval                              AS starttime,
    NOW() - (gs || ' days')::interval + INTERVAL '45 minutes'      AS endtime,
    true                                                            AS timeincludesseconds,
    false                                                           AS success,
    1                                                               AS reprocessinghistoryitemeventtype_id,
    NOW() - (gs || ' days')::interval                              AS starttimereceived
FROM generate_series(1, 20) AS gs
ON CONFLICT (id) DO NOTHING;

-- cycle
INSERT INTO public.cycle
    (id, endoscope_id, creationdate, lastedit,
     starttime, endtime, ispending, cyclestate_id,
     statustime, statusexpirationtime,
     startcyclestate_id, startstateexpirationtime)
SELECT
    99000 + gs                                                      AS id,
    9901                                                            AS endoscope_id,
    NOW()                                                           AS creationdate,
    NOW()                                                           AS lastedit,
    NOW() - (gs || ' days')::interval                              AS starttime,
    NOW() - (gs || ' days')::interval + INTERVAL '45 minutes'      AS endtime,
    false                                                           AS ispending,
    9901                                                            AS cyclestate_id,
    NOW()                                                           AS statustime,
    NOW() + INTERVAL '1 year'                                       AS statusexpirationtime,
    9901                                                            AS startcyclestate_id,
    NOW() + INTERVAL '1 year'                                       AS startstateexpirationtime
FROM generate_series(1, 20) AS gs
ON CONFLICT (id) DO NOTHING;

-- cyclestep  (cycle ↔ reprocessinghistoryitem bridge)
INSERT INTO public.cyclestep
    (id, cycle_id, reprocessinghistoryitem_id,
     starttime, endtime, success, creationdate, retroactive)
SELECT
    99000 + gs                                                      AS id,
    99000 + gs                                                      AS cycle_id,
    99000 + gs                                                      AS reprocessinghistoryitem_id,
    NOW() - (gs || ' days')::interval                              AS starttime,
    NOW() - (gs || ' days')::interval + INTERVAL '45 minutes'      AS endtime,
    false                                                           AS success,
    NOW()                                                           AS creationdate,
    false                                                           AS retroactive
FROM generate_series(1, 20) AS gs
ON CONFLICT (id) DO NOTHING;

-- etddoubleerrorprotocol  (one error row per cycle — keeps single-error invariant)
INSERT INTO public.etddoubleerrorprotocol
    (id, reprocessingdevice_id, reprocessinghistoryitem_id,
     lastedit, creationdate, errortime,
     errornumber, errordescription, blocknumber, stepnumber)
SELECT
    99000 + gs                                                               AS id,
    9901                                                                     AS reprocessingdevice_id,
    99000 + gs                                                               AS reprocessinghistoryitem_id,
    NOW()                                                                    AS lastedit,
    NOW()                                                                    AS creationdate,
    NOW() - (gs || ' days')::interval + INTERVAL '10 minutes'               AS errortime,
    3003                                                                     AS errornumber,
    'Druckluft in APC[1]-Eingang außerhalb des zulässigen Bereichs'          AS errordescription,
    2                                                                        AS blocknumber,
    4240                                                                     AS stepnumber
FROM generate_series(1, 20) AS gs
ON CONFLICT (id) DO NOTHING;
