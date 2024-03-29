defmodule Tracker1Web.TimeblockController do
  use Tracker1Web, :controller

  alias Tracker1.Timeblocks
  alias Tracker1.Timeblocks.Timeblock

  action_fallback Tracker1Web.FallbackController

  def index(conn, _params) do
    timeblocks = Timeblocks.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"timeblock" => timeblock_params}) do
    with {:ok, %Timeblock{} = timeblock} <- Timeblocks.create_timeblock(timeblock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.timeblock_path(conn, :show, timeblock))
      |> render("show.json", timeblock: timeblock)
    end
  end


  def show(conn, %{"id" => id}) do
    timeblock = Timeblocks.get_timeblock!(id)
    render(conn, "show.json", timeblock: timeblock)
  end

  def update(conn, %{"id" => id, "timeblock" => timeblock_params}) do
    timeblock = Timeblocks.get_timeblock!(id)

    with {:ok, %Timeblock{} = timeblock} <- Timeblocks.update_timeblock(timeblock, timeblock_params) do
      render(conn, "show.json", timeblock: timeblock)
    end
  end

  def delete(conn, %{"id" => id}) do
    timeblock = Timeblocks.get_timeblock!(id)

    with {:ok, %Timeblock{}} <- Timeblocks.delete_timeblock(timeblock) do
      send_resp(conn, :no_content, "")
    end
  end
end
