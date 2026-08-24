-- +goose Up
-- +goose StatementBegin
SELECT 'up SQL query';
CREATE TABLE sec.master_menu(
    master_menu_id INTEGER,
    master_menu_status INTEGER DEFAULT 1,
    master_menu_urut INTEGER,
    master_menu_nama TEXT,
    PRIMARY KEY(master_menu_status, master_menu_urut, master_menu_id)
);

COMMENT ON TABLE sec.master_menu IS 'Master Menu';
COMMENT ON COLUMN sec.master_menu.master_menu_id IS 'Id';
COMMENT ON COLUMN sec.master_menu.master_menu_status IS 'Status';
COMMENT ON COLUMN sec.master_menu.master_menu_urut IS 'Urutan';
COMMENT ON COLUMN sec.master_menu.master_menu_nama IS 'Nama';

CREATE OR REPLACE FUNCTION sec.master_menu_get_all()
  RETURNS TABLE(master_menu json) AS $BODY$
BEGIN
RETURN QUERY
  SELECT COALESCE(json_agg(row_to_json(t)), '[]'::json) FROM
        (SELECT
        master_menu_id,
        master_menu_nama
    FROM sec.master_menu
    WHERE master_menu_status = 1 ORDER BY master_menu_urut) t;
END;
$BODY$
  LANGUAGE plpgsql;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
DROP FUNCTION IF EXISTS sec.master_menu_get_all();
DROP TABLE IF EXISTS sec.master_menu CASCADE;
-- +goose StatementEnd
