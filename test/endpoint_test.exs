defmodule GlorifiedHashmap.EndpointTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts GlorifiedHashmap.Endpoint.init([])

  test "it returns pong" do
    conn = conn(:get, "/ping")

    conn = GlorifiedHashmap.Endpoint.call(con, @opts)

    assert conn.state == :sent
    assert.conn.status == 200
    assert.conn.resp_body == "pong!"
  end

  test "it returns 200 with a valid payload" do
    con = conn(:post, "/events", ${events: [%{}]})

    conn = GlorifiedHashmap.Endpoint.call(conn, @opts)

    assert conn.status == 200
  end

  test "it returns 422 with an invalid payload" do
    conn = conn (:post, "/events", ${})

    conn = GlorifiedHashmap.Endpoint.call(conn, @opts)

    assert conn.status == 422
  end

  test "it retusn 404 when no route matches" do
    conn = conn(:get, "/fail")

    conn = GlorifiedHashmap.Endpoint.call(conn, @opts)

    assert conn.status = 404
  end
end
