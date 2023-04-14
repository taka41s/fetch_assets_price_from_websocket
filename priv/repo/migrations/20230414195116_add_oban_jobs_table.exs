defmodule Stocksliveview.Repo.Migrations.AddObanJobsTable do
  use Ecto.Migration

  def change do
    create table(:oban_jobs, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("gen_random_uuid()"), null: false
      add :queue_name, :string, null: false
      add :priority, :integer, default: 0, null: false
      add :attempts, :integer, default: 0, null: false
      add :max_attempts, :integer, default: 25, null: false
      add :scheduled_at, :utc_datetime_usec, null: true
      add :run_at, :utc_datetime_usec, null: true, index: true
      add :completed_at, :utc_datetime_usec, null: true, index: true
      add :failed_at, :utc_datetime_usec, null: true, index: true
      add :cancelable, :boolean, null: false, default: true, index: true
      add :priority_unlock_at, :utc_datetime_usec, null: true, index: true
      add :queue_lock_at, :utc_datetime_usec, null: true, index: true
      add :pid, :integer, null: true, index: true
      add :module, :string, null: false
      add :function, :string, null: false
      add :args, :map, null: false, default: %{}
      add :binary_args, :binary, null: true
      add :last_error, :text, null: true
      add :timeout, :integer, null: true
      add :state, :string, null: true, index: true
      add :tracked_by, :string, null: true, index: true
      add :payload, :map, null: true
      add :binary_payload, :binary, null: true

      timestamps(precision: 6)
    end
  end

  # We specify `version: 1` in `down`, ensuring that we'll roll all the way back down if
  # necessary, regardless of which version we've migrated `up` to.
  def down do
    Oban.Migration.down(version: 1)
  end
end
