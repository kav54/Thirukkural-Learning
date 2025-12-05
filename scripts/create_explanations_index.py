#!/usr/bin/env python3
"""
Create an indexed reference file for children's explanations.
This makes it easy to search and reference specific explanations.
"""

import json

def create_index():
    """Create an indexed reference file."""
    
    # Load the explanations
    with open('/Users/kavya.d/Documents/Tirukkural App/Thirukkural Learning/assets/data/children_explanations.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # Load the original kurals for chapter information
    with open('/Users/kavya.d/Documents/Tirukkural App/Thirukkural Learning/assets/data/kurals.json', 'r', encoding='utf-8') as f:
        kurals_data = json.load(f)
    
    # Create a mapping of kural_no to chapter info
    kural_to_chapter = {}
    for feature in kurals_data['features']:
        props = feature['properties']
        kural_no = props['kural_no']
        kural_to_chapter[kural_no] = {
            'chapter_no': props['adhikarm_no'],
            'chapter_name': props['adhikarm_tamil'],
            'chapter_english': props['adhikarm_english'],
            'section': props['pal_tamil'],
            'section_english': props['pal_english']
        }
    
    # Create indexed reference
    indexed_data = {
        'metadata': data['metadata'],
        'index_by_chapter': {},
        'index_by_section': {},
        'all_explanations': []
    }
    
    # Group by chapter
    for explanation in data['explanations']:
        kural_no = explanation['kural_no']
        chapter_info = kural_to_chapter.get(kural_no, {})
        
        chapter_no = chapter_info.get('chapter_no', 0)
        section = chapter_info.get('section_english', 'Unknown')
        
        # Add to chapter index
        if chapter_no not in indexed_data['index_by_chapter']:
            indexed_data['index_by_chapter'][chapter_no] = {
                'chapter_name': chapter_info.get('chapter_name', ''),
                'chapter_english': chapter_info.get('chapter_english', ''),
                'section': chapter_info.get('section', ''),
                'kurals': []
            }
        
        indexed_data['index_by_chapter'][chapter_no]['kurals'].append({
            'kural_no': kural_no,
            'child_explanation': explanation['child_explanation']
        })
        
        # Add to section index
        if section not in indexed_data['index_by_section']:
            indexed_data['index_by_section'][section] = []
        
        indexed_data['index_by_section'][section].append({
            'kural_no': kural_no,
            'chapter_no': chapter_no,
            'child_explanation': explanation['child_explanation']
        })
        
        # Add to all explanations
        indexed_data['all_explanations'].append({
            'kural_no': kural_no,
            'chapter_no': chapter_no,
            'chapter_name': chapter_info.get('chapter_name', ''),
            'section': section,
            'child_explanation': explanation['child_explanation'],
            'original_english': explanation['original_english']
        })
    
    # Save indexed reference
    with open('/Users/kavya.d/Documents/Tirukkural App/Thirukkural Learning/docs/children_explanations_index.json', 'w', encoding='utf-8') as f:
        json.dump(indexed_data, f, ensure_ascii=False, indent=2)
    
    # Create a human-readable markdown reference
    create_markdown_reference(indexed_data)
    
    print(f"✅ Created indexed reference with:")
    print(f"   - {len(indexed_data['index_by_chapter'])} chapters")
    print(f"   - {len(indexed_data['index_by_section'])} sections")
    print(f"   - {len(indexed_data['all_explanations'])} total explanations")

def create_markdown_reference(indexed_data):
    """Create a markdown reference document."""
    
    md_content = """# Children's Explanations Reference

## Quick Reference Guide
This document provides an indexed reference of all child-friendly explanations organized by section and chapter.

---

"""
    
    # Group by section
    sections = {
        'Virtue': [],
        'Wealth': [],
        'Love': []
    }
    
    for chapter_no, chapter_data in sorted(indexed_data['index_by_chapter'].items()):
        section = chapter_data.get('section', '')
        if 'அறத்துப்பால்' in section:
            sections['Virtue'].append((chapter_no, chapter_data))
        elif 'பொருட்பால்' in section:
            sections['Wealth'].append((chapter_no, chapter_data))
        elif 'இன்பத்துப்பால்' in section or 'காமத்துப்பால்' in section:
            sections['Love'].append((chapter_no, chapter_data))
    
    # Write each section
    for section_name, chapters in sections.items():
        md_content += f"## {section_name} (அறத்துப்பால்)\n\n"
        
        for chapter_no, chapter_data in chapters:
            md_content += f"### Chapter {chapter_no}: {chapter_data['chapter_name']}\n"
            md_content += f"**English:** {chapter_data['chapter_english']}\n\n"
            
            # Show first 3 kurals as examples
            for i, kural_data in enumerate(chapter_data['kurals'][:3]):
                md_content += f"**Kural {kural_data['kural_no']}:**  \n"
                md_content += f"{kural_data['child_explanation']}\n\n"
            
            if len(chapter_data['kurals']) > 3:
                md_content += f"*...and {len(chapter_data['kurals']) - 3} more kurals in this chapter*\n\n"
            
            md_content += "---\n\n"
    
    # Save markdown
    with open('/Users/kavya.d/Documents/Tirukkural App/Thirukkural Learning/docs/children_explanations_reference.md', 'w', encoding='utf-8') as f:
        f.write(md_content)
    
    print(f"📄 Created markdown reference document")

if __name__ == '__main__':
    create_index()
