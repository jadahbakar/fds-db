-- +goose Up
-- +goose StatementBegin
SELECT 'up SQL query';

CREATE TABLE sec.detail_menu(
    detail_menu_master INTEGER,
    detail_menu_id INTEGER,
    detail_menu_status INTEGER DEFAULT 1,
    detail_menu_urut INTEGER,
    detail_menu_nama TEXT,
    PRIMARY KEY(detail_menu_master, detail_menu_status, detail_menu_urut, detail_menu_id)
);

COMMENT ON TABLE sec.detail_menu IS 'Detail Menu';
COMMENT ON COLUMN sec.detail_menu.detail_menu_master IS 'Master Id';
COMMENT ON COLUMN sec.detail_menu.detail_menu_id IS 'Id';
COMMENT ON COLUMN sec.detail_menu.detail_menu_status IS 'Status';
COMMENT ON COLUMN sec.detail_menu.detail_menu_urut IS 'Urutan';
COMMENT ON COLUMN sec.detail_menu.detail_menu_nama IS 'Nama';


CREATE OR REPLACE FUNCTION sec.detail_menu_get_all()
  RETURNS TABLE(detail_menu json) AS $BODY$
BEGIN
RETURN QUERY
  SELECT COALESCE(json_agg(row_to_json(t)), '[]'::json) FROM
        (SELECT
        detail_menu_id,
        detail_menu_nama
    FROM sec.detail_menu
    WHERE detail_menu_status = 1 ORDER BY detail_menu_master, detail_menu_urut) t;
END;
$BODY$
  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sec.detail_menu_get_by_master(param INTEGER)
  RETURNS TABLE(detail_menu json) AS $BODY$
BEGIN
RETURN QUERY
  SELECT COALESCE(json_agg(row_to_json(t)), '[]'::json) FROM
        (
    SELECT
        detail_menu_id,
        detail_menu_nama
    FROM sec.detail_menu
    WHERE detail_menu_status = 1
    AND detail_menu_master = param
    ORDER BY detail_menu_urut
    ) t;
END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION sec.detail_menu_get_by_id(param INTEGER)
  RETURNS TABLE(role json) AS
$BODY$
BEGIN
  RETURN QUERY
   SELECT COALESCE(row_to_json(t), '{}'::json) FROM
          (
                SELECT
            detail_menu_id,
            detail_menu_nama
                FROM sec.detail_menu
                WHERE detail_menu_status = 1 AND detail_menu_id = param
    ) t;
END;
$BODY$
  LANGUAGE plpgsql;

-- +goose StatementEnd
-- +goose Down
