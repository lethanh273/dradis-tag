require 'rails_helper'

describe 'Tag pages:' do
  subject { page }

  before do
    login_to_project_as_user
  end

  describe '#index', js: true do
    before do
      visit tags_path
    end

    context 'without existing tags' do
      it 'renders no tag info' do
        expect(page).to have_content('There are no tags yet.')
      end
    end

    context 'with existing tags' do
      let!(:tags) { create_list(:tag, 5) }

      it 'renders new tag page when new tag button is clicked' do
        click_link 'New Tag'
        expect(current_path).to eq(new_tag_path)
      end

      it 'renders form page when clicking new tag button' do
        visit tags_path
        click_link(href: edit_tag_path(tags.first))
        expect(current_path).to eq(edit_tag_path(tags.first))
      end
    end
  end

  describe '#new' do
    before do
      visit new_tag_path
    end

    it 'creates tag' do
      fill_in :tag_name, with: '!9467bd_important'
      expect { click_button('Create Tag') }.to change{ Tag.count }.by(1)
      expect(page).to have_content('Tag created')
    end
  end

  describe '#update' do
    let(:tag) { create(:tag, name: '!1111_critical') }

    before do
      visit edit_tag_path(tag)
    end

    it 'updates tag when name is changed' do
      fill_in :tag_name, with: '!9467bd_important'
      expect do
        click_button 'Update Tag'
      end.to change { tag.reload.name }.from('!1111_critical').to('!9467bd_important')
    end
  end

  describe '#destroy', js: true do
    let!(:tags) { create_list(:tag, 5) }

    it 'deletes tag' do
      visit tags_path
      page.accept_confirm do
        click_link(href: tag_path(tags.first))
      end
      expect(page).to have_content('Tag destroyed')
      expect(Tag.count).to eq(4)
    end
  end
end
