defmodule ExmealTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Error
  alias Exmeal.Meals.Meal
  alias Exmeal.Users.User

  describe "create_meal/1" do
    test "when all params are valid, inserts a meal into the database." do
      %User{} = insert(:user)

      params = build(:meal_params)

      response = Exmeal.create_meal(params)

      assert {:ok,
              %Meal{
                calories: "100 kcal",
                date: ~N[2016-04-16 13:30:15],
                description: "1 Banana",
                id: _id,
                inserted_at: _inserted_at,
                updated_at: _updated_at,
                user_id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d"
              }} = response
    end

    test "when some param is invalid, returns an error" do
      params = %{
        calories: "",
        date: "",
        description: "",
        user_id: ""
      }

      response = Exmeal.create_meal(params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :insert,
                  changes: %{},
                  errors: [
                    description: {"can't be blank", [validation: :required]},
                    date: {"can't be blank", [validation: :required]},
                    calories: {"can't be blank", [validation: :required]},
                    user_id: {"can't be blank", [validation: :required]}
                  ]
                },
                status: :bad_request
              }} = response
    end
  end

  describe "get_meal_by_id/1" do
    test "when there is a meal with the given id, returns the meal from the database." do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      response = Exmeal.get_meal_by_id(id)

      assert {:ok,
              %Meal{
                calories: "100 kcal",
                date: ~N[2016-04-16 13:30:15],
                description: "1 Banana",
                id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
                inserted_at: _inserted_at,
                updated_at: _updated_at,
                user_id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d"
              }} = response
    end

    test "when there is no an user with the given id, returns an error." do
      response = Exmeal.get_meal_by_id("1e459e18-5847-4832-8aeb-4c29a869b7be")

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end
  end

  describe "delete_meal/1" do
    test "When there is a meal with the given ID, deletes the meal." do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      response = Exmeal.delete_meal(id)

      assert {:ok,
              %Meal{
                calories: "100 kcal",
                date: ~N[2016-04-16 13:30:15],
                description: "1 Banana",
                id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a meal with the given ID, returns an error." do
      response = Exmeal.delete_meal("1e459e18-5847-4832-8aeb-4c29a869b7be")

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end
  end

  describe "update_meal/2" do
    test "When all params are valid and there is a user with the given ID, updates the meal" do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      params =
        build(:meal_params,
          calories: "200 kcal",
          date: "2016-05-10 12:20:10",
          description: "2 Bananas"
        )

      response = Exmeal.update_meal(id, params)

      assert {:ok,
              %Meal{
                calories: "200 kcal",
                date: ~N[2016-05-10 12:20:10],
                description: "2 Bananas",
                id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
                inserted_at: _inserted_at,
                updated_at: _updated_at,
                user_id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d"
              }} = response
    end

    test "When there is no a meal with the given ID, returns an error" do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      params = %{
        calories: "200 kcal",
        date: "2016-05-10 12:20:10",
        description: "2 Bananas"
      }

      response = Exmeal.update_meal(id, params)

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end

    test "When some param is invalid, returns an error" do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      params = %{
        calories: "",
        date: "",
        description: "",
        user_id: ""
      }

      response = Exmeal.update_meal(id, params)

      assert {
               :error,
               %Error{
                 result: %Ecto.Changeset{
                   action: :update,
                   changes: %{},
                   errors: [
                     description: {"can't be blank", [validation: :required]},
                     date: {"can't be blank", [validation: :required]},
                     calories: {"can't be blank", [validation: :required]},
                     user_id: {"can't be blank", [validation: :required]}
                   ],
                   valid?: false
                 },
                 status: :bad_request
               }
             } = response
    end
  end

  describe "create_user/1" do
    test "When all params are valid, inserts a user into the database." do
      params = build(:user_params)

      response = Exmeal.create_user(params)

      assert {:ok,
              %User{
                cpf: "001.324.030-23",
                email: "andre@email.com",
                id: _id,
                inserted_at: _inserted_at,
                name: "André Lara Amorim",
                updated_at: _updated_at
              }} = response
    end

    test "When any parameter is blank, returns an error" do
      params = %{
        cpf: "",
        email: "",
        name: ""
      }

      response = Exmeal.create_user(params)

      assert {
               :error,
               %Error{
                 result: %Ecto.Changeset{
                   action: :insert,
                   changes: %{},
                   errors: [
                     name: {"can't be blank", [validation: :required]},
                     cpf: {"can't be blank", [validation: :required]},
                     email: {"can't be blank", [validation: :required]}
                   ],
                   valid?: false
                 },
                 status: :bad_request
               }
             } = response
    end

    test "When the email parameter is invalid, returns an error" do
      params = build(:user_params, email: "emailinvalido.com")

      response = Exmeal.create_user(params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :insert,
                  changes: %{
                    cpf: "001.324.030-23",
                    email: "emailinvalido.com",
                    name: "André Lara Amorim"
                  },
                  errors: [email: {"has invalid format", [validation: :format]}],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end

  describe "get_user_by_id/1" do
    test "When there is a user with the given ID, returns the user" do
      %User{id: id} = insert(:user)

      response = Exmeal.get_user_by_id(id)

      assert {:ok,
              %User{
                cpf: "001.324.030-23",
                email: "andre@email.com",
                id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
                inserted_at: _inserted_at,
                name: "André Lara Amorim",
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a user with the given ID, returns an error" do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      response = Exmeal.get_user_by_id(id)

      assert {:error, %Error{result: "User not found!", status: :not_found}} = response
    end
  end

  describe "delete_user/1" do
    test "When there is a user with the given ID, deletes the user." do
      %User{id: id} = insert(:user)

      response = Exmeal.delete_user(id)

      assert {:ok,
              %User{
                cpf: "001.324.030-23",
                email: "andre@email.com",
                id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
                inserted_at: _inserted_at,
                name: "André Lara Amorim",
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a user with the given ID, returns an error." do
      response = Exmeal.delete_user("1e459e18-5847-4832-8aeb-4c29a869b7be")

      assert {:error, %Error{result: "User not found!", status: :not_found}} = response
    end
  end

  describe "update_user/2" do
    test "When all params are valid and there is a user with the given ID, updates the user" do
      %User{id: id} = insert(:user)

      params =
        build(:user_params,
          cpf: "111.222.333-44",
          email: "haker@mail.com",
          name: "Hacker Teste"
        )

      response = Exmeal.update_user(id, params)

      assert {:ok,
              %User{
                cpf: "111.222.333-44",
                email: "haker@mail.com",
                id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
                inserted_at: _inserted_at,
                name: "Hacker Teste",
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a user with the given ID, returns an error" do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      params = %{
        cpf: "111.222.333-44",
        email: "haker@mail.com",
        name: "Hacker Teste"
      }

      response = Exmeal.update_user(id, params)

      assert {:error, %Error{result: "User not found!", status: :not_found}} = response
    end

    test "When some param is invalid, returns an error" do
      %User{id: id} = insert(:user)

      params = %{
        cpf: "",
        email: "",
        name: ""
      }

      response = Exmeal.update_user(id, params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :update,
                  changes: %{},
                  errors: [
                    name: {"can't be blank", [validation: :required]},
                    cpf: {"can't be blank", [validation: :required]},
                    email: {"can't be blank", [validation: :required]}
                  ],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end
end
