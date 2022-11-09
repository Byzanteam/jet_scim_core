defmodule JetScimCore.Notification.Event do
  @moduledoc """
  SCIM Event Notification.

  link: https://datatracker.ietf.org/doc/id/draft-hunt-scim-notify-00.txt

  ## Event Type
  ADD
     The specified resource URI was added to the feed.  An add does not
     necessarily indicate a resource is new or has been recently
     created, but rather that it has been added to a feed.  For
     example, an existing user has had a new role (e.g.  CRM_User)
     added to their profile which has caused their resource to join a
     feed.

  CREATE
     The new resource URI has been created at the service provider and
     has been added to the feed.  When a CREATE event is sent, a
     corresponding ADD event is not issued.  For example, a new user
     was created via HTTP POST, whose attribute profile met the
     criteria of a current feed.

  ACTIVATE
     The specified resource (e.g.  User) has been activated or is
     otherwise available for use.

  MODIFY
     The specified resource has been updated (e.g. one or more
     attributes has changed).

  DEACTIVATE
     The specified resource (e.g.  User) has been deactivated.

  DELETE  The specified resource has been deleted from the service
     provider and is also removed from the feed.  When a DELETE is
     sent, a corresponding REMOVE is not issued.

  REMOVE
     The specified resource has been removed from the feed.  Removal
     does not indicate that the resource was deleted or otherwise
     deactivated.

  PASSWORD
     The specified resource (e.g.  User) has changed its password.  If
     secure exchange is possible with the subscriber, the event may
     also include the raw password update text.  A PASSWORD event MUST
     be transmitted in encrypted form (see Section 3.3).

  CONFIRMATION
     A special event that is used during Polling Feed
     Registrations and Web Callback URI subscriptions to confirm
     successful configuration of an event feed.  The contents of a
     CONFIRMATION event SHALL be defined by the registration process
     documented in following sections.
  """

  use Ecto.Schema

  @primary_key false

  @event_types ~w[add create activate modify deactivate delete remove password confirmation]a

  embedded_schema do
    field :resource_uris, {:array, :string}
    field :event_type, Ecto.Enum, values: @event_types
    field :attributes, {:array, :string}, default: []
    field :values, :map, default: %{}
  end

  @type t() :: %__MODULE__{
          resource_uris: [String.t()],
          event_type: atom(),
          attributes: [String.t()],
          values: map()
        }

  @spec new(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t(t())}
  def new(params) do
    __MODULE__
    |> struct()
    |> Ecto.Changeset.cast(params, [:resource_uris, :event_type, :attributes, :values])
    |> Ecto.Changeset.validate_required([:resource_uris, :event_type])
    |> Ecto.Changeset.apply_action(nil)
  end
end