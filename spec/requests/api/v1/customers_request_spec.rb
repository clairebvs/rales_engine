require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do

    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    customers = JSON.parse(response.body)

    expect(customers.count).to eq(3)
  end
  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end
  
  # relationships endpoint
  context 'GET /api/v1/customers/:id/invoices' do
    it 'returns a collection of associated invoices' do
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      create_list(:invoice, 5, customer_id: customer_1.id, merchant_id: merchant_1.id)

      get "/api/v1/customers/#{customer_1.id}/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)

      expect(invoices.count).to eq(5)
    end
  end

  context 'GET /api/v1/customers/:id/transactions' do
    it 'returns a collection of associated transactions' do
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
      create_list(:transaction, 8, invoice_id: invoice_1.id)

      get "/api/v1/customers/#{customer_1.id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(8)
    end
  end
  context 'GET /api/v1/customers/find?parameters' do
    it 'can find one customer by parameters' do
      customer = create(:customer)

      get "/api/v1/customers/find?id=#{customer.id}"

      expect(response).to be_successful

      cust = JSON.parse(response.body)
      expect(cust["id"]).to eq(customer.id)

      get "/api/v1/customers/find?first_name=#{customer.first_name}"
      cust = JSON.parse(response.body)
      expect(cust["first_name"]).to eq(customer.first_name)

      get "/api/v1/customers/find?last_name=#{customer.last_name}"
      cust = JSON.parse(response.body)
      expect(cust["last_name"]).to eq(customer.last_name)
    end
  end
  context 'GET /api/v1/customers/find_all?parameters' do
    it 'can find all customers by parameters' do
      customer1 = create(:customer)
      customer2 = create(:customer)

      get "/api/v1/customers/find_all?id=#{customer1.id}"

      expect(response).to be_successful

      customers = JSON.parse(response.body)
      expect(customers.count).to eq(1)

      get "/api/v1/customers/find_all?first_name=#{customer1.first_name}"
      customers = JSON.parse(response.body)
      expect(customers.count).to eq(2)

      get "/api/v1/customers/find_all?last_name=#{customer1.last_name}"
      customers = JSON.parse(response.body)
      expect(customers.count).to eq(2)
    end
  end
  context 'GET/api/v1/customers/random.json' do
    it 'can find a random customer' do
      customer = create_list(:customer, 4)

      get "/api/v1/customers/random"

      customer = JSON.parse(response.body)

      expect(response).to be_successful
      expect(customer.count).to eq(1)
    end
  end
end
