-- +goose Up
-- +goose StatementBegin
CREATE TABLE sec.parameter(
    parameter_id TEXT PRIMARY KEY,
    parameter_value TEXT,
    parameter_deskripsi TEXT
);

COMMENT ON TABLE sec.parameter IS 'Global Parameter';
COMMENT ON COLUMN sec.parameter.parameter_id IS 'Id';
COMMENT ON COLUMN sec.parameter.parameter_value IS 'value';
COMMENT ON COLUMN sec.parameter.parameter_deskripsi IS 'Deskripsi';
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS sec.parameter CASCADE;
-- +goose StatementEnd
